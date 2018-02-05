//
//  NibLoadable.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadable: class { }


// MARK: - Nib Name
extension NibLoadable where Self: UIView {
  
  static var nibName: String {
    return String(describing: self)
  }
  
}
