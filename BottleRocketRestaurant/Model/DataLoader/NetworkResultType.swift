//
//  NetworkResultType.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

enum NetworkResultType<T, E> where E: Error {
  case success(T)
  case failure(E)
}
