//
//  Error.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 3/3/24.
//

import Foundation
enum locationError: Error {
    case unableToReverseGeocodeLocation
    case locationServicesOff
}
