//
//  Restaurant.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/21/24.
//

import Foundation

struct Restaurant: Codable, Identifiable{
    
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
    var location: loc
    var phone: String
    var display_phone: String
    var distance: Double
}

struct category: Codable, Identifiable{
    var id: String?
    var alias: String
    var title: String
}
struct coordinates:Codable{
    var longitude: Double
    var latitude: Double
}
struct loc: Codable{
    var address1: String
    var address2: String?
    var address3: String?
    var city: String
    var zip_code: String
    var country: String
    var state: String
    var display_address: [String]

    
}
