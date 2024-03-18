
import SwiftUI
import Foundation

class Network: ObservableObject {
    
    @Published var businessData: [Restaurant] = []
    @Published var categoryDict: [String: CategoryItem] = [:]
    
    @Published var questionChoices: [String] = []
    @Published var notChosen: [String] = []
    @Published var currentSelectionIndex: Int = 0
    @Published var notChosenIndex: Int = 1
    
    @Published var currQuestion: [String] = ["0","1"]
    @Published var gameOver: Bool = false
    @Published private(set) var length = 0
    
    
    func initVar(){
        questionChoices = []
        notChosen = []
        currentSelectionIndex = 0
        notChosenIndex = 1
        currQuestion = ["0","1"]
        gameOver = false
        categoryDict = [:]
    }
    
    
    
    func gameStart(longitude: Double, latitude:Double, radius:Double, price: [Int], canContinue: Binding<Bool>){
        Task{
            print("Getting buisnesses latitude=\(latitude)&longitude=\(longitude)&limit=5&radius=\(milesToMeters(miles: radius))")
            await fetchYelpBusinesses(latitude: latitude,longitude: longitude,radius: milesToMeters(miles: radius), price: price )
            initVar()
            makeCategoryDict()
            filterCategoryByLength(length: 1)
            initQuestionChoices()
            print(questionChoices)
            if(questionChoices.count >= 2){
                getNextQuestion()
                canContinue.wrappedValue = true
            }
            
            
        }
       
        
        
    }
    
    func milesToMeters(miles: Double)->Int{
        return Int(miles*1609)
    }
    enum networkError: Error {
        case notInitialized
        
    }
    func fetchYelpBusinesses(latitude: Double , longitude: Double ,radius: Int, price: [Int] ) async  {
        var priceStr: String = ""
        for i in price{
            priceStr += "&price=\(i)"
        }
        print("https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)\(priceStr)&sort_by=best_match&limit=50")
        let apikey = API_KEY
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)\(priceStr)&open_now=true&sort_by=best_match&limit=50")
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse?.statusCode)
            let b_data: Businesses = try JSONDecoder().decode(Businesses.self, from: data)
            self.businessData = b_data.businesses
            
        }catch{
            print(error)
        }
    
        /*
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            do {
                //let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Businesses
                //self.busineses = json
                //print(json)
                let data: Businesses = try JSONDecoder().decode(Businesses.self, from: data!)
                
                self.businessData = data.businesses
                print(self.businessData)
                
            } catch {
                print("caught \(error)")
            }
            }.resume()
         */
    }
    func makeCategoryDict(){
        
        for place in self.businessData{
            
            for categoryItem in place.categories{
                let title = categoryItem.title
                if(!categoryDict.keys.contains(title)){
                    categoryDict[title] = CategoryItem()
                    categoryDict[title]?.addRestaurant(restaurant: place)
                }else{
                    categoryDict[title]?.addRestaurant(restaurant: place)
                }
            }
        }
        
        
        
    }
    //filter throught the category to remove listings that have less then length restaurants
    func filterCategoryByLength(length:Int = 1){
        var keysToRemove: [String] = []
        for (key, categoryItem) in categoryDict {
            if categoryItem.restaurants.count <= length {
                keysToRemove.append(key)
            }
        }
        for key in keysToRemove {
            categoryDict.removeValue(forKey: key)
        }
    }
    func initQuestionChoices(){
        self.questionChoices = Array(self.categoryDict.keys)
    }
    func checkIfEnoughtQuestions()->Bool{
        if(Array(self.categoryDict.keys).count >= 3){
            return true
        }
        return false
    }
    
    func getNextQuestion(){
        let thisQuestion: [String] = [questionChoices[currentSelectionIndex],questionChoices[notChosenIndex]]
        self.currQuestion = thisQuestion
        
    }
    func selectedAnswer(answer: String){
        if(!checkIfMoreQuestions()){
            print(gameOver = true)
            gameOver = true
        }
        if(answer == questionChoices[currentSelectionIndex]){
            self.categoryDict[questionChoices[notChosenIndex]]?.decreaseRating()
            self.notChosenIndex += 1
            self.categoryDict[questionChoices[currentSelectionIndex]]?.increaseRating()
        }else{
            self.currentSelectionIndex = notChosenIndex
            self.notChosenIndex += 1
        }
        self.getNextQuestion()
        
        
    }
    //returns true if more questions
    func checkIfMoreQuestions()->Bool{
        return notChosenIndex+1 < questionChoices.count-1
        
    }
    
    func getResult() -> [Restaurant]{
        print(categoryDict[self.questionChoices[currentSelectionIndex]]!.restaurants)
        return categoryDict[self.questionChoices[currentSelectionIndex]]!.restaurants
    }
    
    func getProgress()->Double{
        return Double(notChosenIndex) / Double(questionChoices.count)
    }

}

