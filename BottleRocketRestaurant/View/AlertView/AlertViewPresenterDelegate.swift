//
//  AlertViewPresenterDelegate.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

protocol AlertViewPresenterDelegate: class {
  func alertView(_ alertViewPresenter: AlertViewPresenter, didSubmit result: String)
}
