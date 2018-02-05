//
//  CategoryType.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

enum CategoryType: String {
    case barandGrill = "Bar and Grill"
    case burger = "Burgers"
    case coffeeAndBreakfast = "Coffee and Breakfast"
    case fastFoodBurgers = "Fast Food Burgers"
    case japanese = "Japanese"
    case mexican = "Mexican"
    case preparedEats = "Prepared Eats"
    case pub = "Pub"
    case seafood = "Seafood"
    case tapHouse = "Tap House"
    case texMex = "Tex Mex"
    case thai = "Thai"
    case wingJoint = "Wing Joint"
    case none
}


// MARK: CustomStringConvertible protocol
extension CategoryType: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .barandGrill:
            return "Bar and Grill"
            
        case .burger:
            return "Burgers"
            
        case .coffeeAndBreakfast:
            return "Coffee and Breakfast"
            
        case .fastFoodBurgers:
            return "Fast Food Burgers"
            
        case .japanese:
            return "Japanese"
            
        case .mexican:
            return "Mexican"
            
        case .preparedEats:
            return "Prepared Eats"
            
        case .pub:
            return "Pub"
            
        case .seafood:
            return "Seafood"
            
        case .tapHouse:
            return "Tap House"
            
        case .texMex:
            return "Tex Mex"
            
        case .thai:
            return "Thai"
            
        case .wingJoint:
            return "Wing Joint"
            
        case .none:
            return "Not Available"
        }
    }
    
}
