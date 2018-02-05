//
//  RestaurantResponse.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct RestaurantResponse: Decodable {
    var restaurants: [Restaurant]
}
