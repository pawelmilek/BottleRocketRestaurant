//
//  RestaurantDetailMapViewDelegate.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

protocol RestaurantDetailMapViewDelegate: class {
    func restaurantDetailMapView(_ restaurantDetailMapView: RestaurantDetailMapView, didPressOpenMpasDirection button: UIButton)
    func restaurantDetailMapView(_ restaurantDetailMapView: RestaurantDetailMapView, didPressShowDetails button: UIButton)
}


// MARK: - Optional
extension RestaurantDetailMapViewDelegate {
    func restaurantDetailMapView(_ restaurantDetailMapView: RestaurantDetailMapView, didPressShowDetails button: UIButton) {}
}
