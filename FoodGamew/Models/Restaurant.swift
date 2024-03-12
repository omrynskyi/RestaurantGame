//
//  Restaurant.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/21/24.
//
import MapKit
import Foundation

struct Restaurant: Codable, Identifiable, Hashable{
    
    var id: String
    var alias: String
    var name: String
    var image_url: String
    var is_closed: Bool
    var url: String
    var review_count: Int
    var categories: [category]
    var rating: Double
    var coordinates: coordinates
    var transactions: [String]
    var price: String?
    var location: loc?
    var phone: String
    var display_phone: String
    var distance: Double
    
    func openAppleMaps() {
        let geocoder = CLGeocoder()
        
        // Geocode the address to get coordinates
        geocoder.geocodeAddressString(self.location!.display_address.joined(separator: " ")) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first,
               let location = placemark.location {
                
                // Create a map item with the location
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate))
                mapItem.name = self.location!.display_address.joined(separator: " ")
                
                // Open Apple Maps
                mapItem.openInMaps(launchOptions: nil)
            }
        }
    }
    func openInYelp() {
        let YelpURL = URL(string:self.url)!
        if UIApplication.shared.canOpenURL(YelpURL)
        {
            UIApplication.shared.open(YelpURL)
        } else {
            UIApplication.shared.open(URL(string: "http://yelp.com/")!)
        }
    }

    
}

struct category: Codable, Identifiable, Hashable{
    var id: String?
    var alias: String
    var title: String
}
struct coordinates:Codable, Hashable{
    var longitude: Double
    var latitude: Double
}
struct loc: Codable, Hashable{
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String
    var zip_code: String
    var country: String
    var state: String
    var display_address: [String]

    
}
