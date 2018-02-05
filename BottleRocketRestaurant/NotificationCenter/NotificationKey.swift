//
//  NotificationKey.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

enum NotificationKey: String {
  case mapAnnotationSelected = "MapAnnotationSelected"
  
  var name: Notification.Name {
    return Notification.Name(self.rawValue)
  }
}
