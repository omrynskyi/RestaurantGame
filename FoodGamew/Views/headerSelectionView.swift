//
//  headerSelectionView.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 3/3/24.
//
import CoreLocation
import SwiftUI

struct headerSelectionView: View{
    @Binding var userLocation: String
    @Binding var userRadius: Double
    @Binding var longitude: Double
    @Binding var latitude: Double
    @Binding var canContinue: Bool
    
    @State private var showingBar:Bool = false
    func locationServices() async throws {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!

        if
           CLLocationManager.authorizationStatus()==CLAuthorizationStatus.authorizedWhenInUse
        {
            currentLocation = locManager.location
        }else{
            throw locationError.locationServicesOff
        }
        self.longitude = currentLocation.coordinate.longitude
        self.latitude = currentLocation.coordinate.latitude
        
        do{
            var placemark = try await CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)).first
            let reversedGeoLocation = GeoLocation(with: placemark!)
            userLocation = "\(reversedGeoLocation.city), \(reversedGeoLocation.state)"
        }catch{
            throw locationError.unableToReverseGeocodeLocation
        }
        
       // CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)) { placemarks, error in

                   // guard let placemark = placemarks?.first else {
                    //    let errorString = error?.localizedDescription ?? "Unexpected Error"
                   //     throw locationError.unableToReverseGeocodeLocation
                  //
                 //   }

                  //  let reversedGeoLocation = GeoLocation(with: placemark)
                  //  userLocation = "\(reversedGeoLocation.city), \(reversedGeoLocation.state)"
                //}
    }
    
    
    var body:some View{
        
        VStack{
            HStack {
                // First Component (70% width)
                HStack {
                    Text(userLocation)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Image(systemName: "location")
                        .resizable()
                        .frame(width: 20, height: 20)
                        
                    
                }
                .onAppear(){
                    Task{
                        do{
                            try await locationServices()
                        }catch locationError.unableToReverseGeocodeLocation{
                            print("Unable to reverse geocode the given location.")
                        }catch locationError.locationServicesOff{
                            print("Please turn on location services")
                        }catch{
                            print("Something went wrong")
                        }
                        canContinue = true
                    }
                }
                .frame(width: 350 * 0.65, height: 50) // 70% of 330
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
            .frame(width: 350) // Total width
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
