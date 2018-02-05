//
//  UserInterfaceCheckable.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

protocol UserInterfaceCheckable { }

extension UserInterfaceCheckable {
    
    var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
}
