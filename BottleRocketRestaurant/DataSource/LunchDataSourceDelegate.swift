//
//  LunchDataSourceDelegate.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

protocol LunchDataSourceDelegate: class, UICollectionViewDataSource, UICollectionViewDelegate {
    weak var delegatorVC: UIViewController? { get }
    var items: [Restaurant]? { get set }
    
    init(items: [Restaurant]?, delegatorVC: UIViewController?)
}


// MARK: - Item at index
extension LunchDataSourceDelegate {
    
    func item(at indexPath: IndexPath) -> Restaurant? {
        let row = indexPath.row
        return items?[row]
    }
    
}


// MARK: - Number of items
extension LunchDataSourceDelegate {
    
    var numberOfItems: Int {
        return items?.count ?? 0
    }
    
}
