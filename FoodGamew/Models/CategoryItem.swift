//
//  Categories.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/21/24.
//

import Foundation

struct CategoryItem{
    var restaurants: [Restaurant] = []
    var rating: Int = 0
    
    mutating func addRestaurant(restaurant: Restaurant){
        restaurants.append(restaurant)
    }
    mutating func increaseRating(){
        self.rating += 1
    }
    mutating func decreaseRating(){
        self.rating += 1
    }
}
