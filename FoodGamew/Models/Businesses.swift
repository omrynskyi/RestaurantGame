//
//  Businesses.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/22/24.
//

import Foundation

struct Businesses:Codable{
    var businesses: [Restaurant]
    var total: Int
    var region: Region
    
    
}
struct Region: Codable {
    var center : Center
}
struct Center: Codable{
    var latitude: Double
    var longitude: Double
}
