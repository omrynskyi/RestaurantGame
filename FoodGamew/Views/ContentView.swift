
import SwiftUI
import CoreLocation

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

struct ContentView: View {
    @State private var userLocation: String = "Loading..."
    @State private var userRadius: Double = 5
    
    @State private var longitude: Double = 0
    @State private var latitude: Double = 0
    @State private var selectedCount: Int = 0
    @State var priceExluded: Int = 0
    @State var priceArr: [Int] = []
    
    @State var canContinue: Bool = false
    
    var body: some View {
        ZStack{
            NavigationView{
                ScrollView{
                    VStack{
                        Spacer()
                        headerSelectionView(userLocation: $userLocation, userRadius: $userRadius, longitude: $longitude, latitude: $latitude, canContinue: $canContinue)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        
                        Text("Select Price Range")
                            .font(.system(size: 20, weight:.bold))
                            .foregroundColor(.primary)
                        PriceSelectionView(selectedCount:$selectedCount, priceExluded: $priceExluded, priceArr: $priceArr).padding(EdgeInsets(top: 1, leading: 0, bottom: 7, trailing: 0))
                        Spacer()
                        NavigationLink{
                            if(latitude != 0 && canContinue){

                                let network: Network = Network()
                                SelectionView(userRadius: self.userRadius, longitude: self.longitude, latitude: self.latitude, priceLimit: priceArr)
                                    .environmentObject(network)
                            }
                        }label:{
                            GameCard(name: "THIS OR THAT",gradient: [Color.green,Color.blue,Color.pink])
                            
                        }
                        Text("MORE COMING SOON")
                            .frame(width: 330, height: 80,alignment: .center)
                            .font(.system(size: 28, weight:.bold))
                            .background(LinearGradient(gradient: Gradient(colors: [Color.red,Color.blue,Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundColor(Color.white)
                            .cornerRadius(25)
                        
                        
                        
                        
                    }
                }
            }
            
            
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait).preferredColorScheme(.dark)

    }
}

