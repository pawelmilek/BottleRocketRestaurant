//
//  LogEventType.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

enum LogEventType: String {
  case error = "[Error]"
  case info = "[Info]"
  case debug = "[Debug]"
  case warning = "[Warning]"
  case server = "[Server]"
}
