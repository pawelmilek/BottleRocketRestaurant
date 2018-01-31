//
//  NetworkError.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

enum NetworkError: ErrorHandleable {
  case unknownFormat
  case dataNotAvailable
}


// MARK: ErrorHandleable protocol
extension NetworkError {
  
  var description: String {
    switch self {
    case .unknownFormat:
      return "Unknown Format"
      
    case .dataNotAvailable:
      return "Data Not Available"
    }
  }
  
}