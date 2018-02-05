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
  
  func handle() {
    AlertViewPresenter.shared.presentError(withMessage: self.description)
  }
  
}
