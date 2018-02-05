//
//  Registrable.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

protocol Registrable: class {}

extension Registrable where Self: UICollectionView {
  
  func register<T: UICollectionViewCell>(cell: T.Type) {
    let nib = UINib(nibName: T.nibName, bundle: nil)
    register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
  }
  
}

extension Registrable where Self: UITableView {
    
    func register<T: UITableViewCell>(cell: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
}
