
import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var userLocation: String = "Loading..."
    @State private var userRadius: Double = 5
    var body: some View {
        
        ZStack{
            NavigationView{
                ScrollView{
                    VStack{
                        Spacer()
                        headerSelectionView(userLocation: $userLocation, userRadius: $userRadius)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        
                        NavigationLink(destination: {
                            SelectionView()
                        },label:{
                            Text("WOULD YOU RATHER")
                                .frame(width: 330, height: 330)
                                .font(.system(size: 60, weight:.bold))
                                .background(LinearGradient(gradient: Gradient(colors: [Color.red,Color.indigo,Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .foregroundColor(Color.white)
                                .cornerRadius(30)
                        })
                        Button{
                            
                        }label:{
                            Text("THIS OR THAT")
                                .frame(width: 330, height: 330)
                                .font(.system(size: 60, weight:.bold))
                                .background(LinearGradient(gradient: Gradient(colors: [Color.green,Color.blue,Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .foregroundColor(Color.white)
                                .cornerRadius(30)
                            
                            
                        }
                        Spacer()
                        
                    }
                }
            }
            
            
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}

struct headerSelectionView: View{
    @Binding var userLocation: String
    @Binding var userRadius: Double
    @State private var showingBar:Bool = false
    func locationServices(){
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!

        if
           CLLocationManager.authorizationStatus()==CLAuthorizationStatus.authorizedWhenInUse
        {
            currentLocation = locManager.location
        }
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)) { placemarks, error in

                    guard let placemark = placemarks?.first else {
                        let errorString = error?.localizedDescription ?? "Unexpected Error"
                        print("Unable to reverse geocode the given location. Error: \(errorString)")
                        return
                    }

                    let reversedGeoLocation = GeoLocation(with: placemark)
            userLocation = "\(reversedGeoLocation.city), \(reversedGeoLocation.state)"
                }
    }
    
    
    var body:some View{
        
        VStack{
            HStack {
                // First Component (70% width)
                HStack {
                    Text(userLocation)
                        .font(.headline)
                    
                    Image(systemName: "location")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .onAppear(){
                    locationServices()
                }
                .frame(width: 330 * 0.6, height: 50) // 70% of 330
                .background(Color("AccentGray"))
                .cornerRadius(10)
                // Second Component (30% width)
                HStack {
                    Button{
                        if(showingBar){
                            showingBar = false
                        }
                        else{
                            showingBar = true
                        }
                    }label:{
                        Text("\(userRadius,specifier: "%.1f") mil")
                            .font(.headline)
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                .frame(width: 330 * 0.3, height: 50) // 30% of 330
                .background(Color("BackgroundGray"))
                .cornerRadius(10)
                .offset(x:-20)
            }
            .frame(width: 330) // Total width
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .offset(x:10)
        }
        if(showingBar){
            HStack{
                Spacer()
                Text("1")
                Slider(value: $userRadius, in: 1...20)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                Text("20")
                Spacer()
            }
            .frame(width: 315,height: 50) // Total width
            .background(Color("BackgroundGray"))
            
            .cornerRadius(10)
        }
        
        
    }
}

struct GeoLocation {
    let name: String
    let streetName: String
    let city: String
    let state: String
    let zipCode: String
    let country: String
    init(with placemark: CLPlacemark) {
            self.name           = placemark.name ?? ""
            self.streetName     = placemark.thoroughfare ?? ""
            self.city           = placemark.locality ?? ""
            self.state          = placemark.administrativeArea ?? ""
            self.zipCode        = placemark.postalCode ?? ""
            self.country        = placemark.country ?? ""
        }

}
