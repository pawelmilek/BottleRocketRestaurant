//
//  RestaurantMapDataSource.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

final class RestaurantMapDataSource: NSObject, RestaurantMapDataSourceDelegate, UserInterfaceCheckable {
    var items: [Restaurant]
    
    init(items: [Restaurant]) {
        self.items = items
    }
}


// MARK: - UITableViewDataSource protocol
extension RestaurantMapDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cell: RestaurantMapTableViewCell.self, for: indexPath)
        let cellItem = item(at: indexPath)
        cell.configure(by: cellItem)
        return cell
    }
    
}


// MARK: - UITableViewDelegate protocol
extension RestaurantMapDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellItem = item(at: indexPath)
        NotificationCenter.default.post(name: NotificationKey.mapAnnotationSelected.name, object: nil,
                                        userInfo: [NotificationUserInfoKey.mapAnnotationSelected.rawValue: cellItem])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

