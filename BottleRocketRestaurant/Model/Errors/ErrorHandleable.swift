//
//  ErrorHandleable.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

protocol ErrorHandleable: Error, CustomStringConvertible { }


// MARK: - Handle errors
extension ErrorHandleable {
  
  static func handle(error: Self) {
    AlertViewPresenter.sharedInstance.presentErrorAlert(withMessage: error.description)
  }
  
}
