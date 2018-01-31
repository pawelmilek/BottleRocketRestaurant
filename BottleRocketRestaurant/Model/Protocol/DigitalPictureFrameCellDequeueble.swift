//
//  BottleRocketRestaurantCellDequeueble.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

protocol DigitalPictureFrameCellDequeueble: class { }

extension DigitalPictureFrameCellDequeueble where Self: UITableView {
  
  func dequeueDigitalPictureFrameCell<T: UITableViewCell>(cell: T.Type) -> T {
    let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    return cell
  }
  
}
