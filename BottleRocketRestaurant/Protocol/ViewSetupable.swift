//
//  ViewSetupable.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

@objc protocol ViewSetupable {
  func setup()
  @objc optional func setupStyle()
  @objc optional func setupLayout()
}
