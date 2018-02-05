//
//  Address.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

protocol Address {
    var street: String { get }
    var city: String { get }
    var state: String { get }
    var zipcode: String? { get }
    var country: String { get }
    var countryCode: String { get }
}


// MARK: Complete Address
extension Address {
    
    var completeAddress: String {
        var fullAddrs: String = ""
        fullAddrs += self.street
        fullAddrs += ", "
        fullAddrs += self.city
        fullAddrs += ", "
        fullAddrs += self.state
        fullAddrs += " "
        fullAddrs += self.zipcode ?? ""
        fullAddrs += " "
        fullAddrs += self.country
        
        return fullAddrs
    }
    
}
