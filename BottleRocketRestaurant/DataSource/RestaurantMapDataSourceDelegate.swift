//
//  RestaurantMapDataSourceDelegate.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

protocol RestaurantMapDataSourceDelegate: class, UITableViewDataSource, UITableViewDelegate {
    var items: [Restaurant] { get set }
    
    init(items: [Restaurant])
}

// MARK: - Item at index
extension RestaurantMapDataSourceDelegate {
    
    func item(at indexPath: IndexPath) -> Restaurant {
        let row = indexPath.row
        return items[row]
    }
    
}


// MARK: - Number of items
extension RestaurantMapDataSourceDelegate {
    
    var numberOfItems: Int {
        return items.count
    }
    
}
