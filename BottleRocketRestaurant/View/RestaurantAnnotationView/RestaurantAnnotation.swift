//
//  RestaurantAnnotation.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit
import MapKit

final class RestaurantAnnotation: NSObject, MKAnnotation {
    var restaurant: Restaurant
    var coordinate: CLLocationCoordinate2D {
        let latitude = restaurant.location.coordinate.latitude
        let longitude = restaurant.location.coordinate.longitude
        let coordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return coordinate2D
    }
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        super.init()
    }
    
    var title: String? {
        return restaurant.name
    }
    
    var subtitle: String? {
        return restaurant.location.street
    }
}
