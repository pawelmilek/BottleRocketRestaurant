//
//  WebServiceResultType.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

enum WebServiceResultType<T, E> where E: Error {
  case success(T)
  case failure(E)
}
