//
//  MapApplication.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

enum NativeMapsHandler {
    case googleMaps
    case appleMaps
}


// MARK: Open for coordinates
extension NativeMapsHandler {
    
    func open(at coordinate: Coordinate, withLocationName name: String) {
        var locationName: String {
            let parsedName = "q=\(name.replacingOccurrences(of: " ", with: "+"))"
            return parsedName
        }
        
        
        switch self {
        case .googleMaps:
            let googleUrlScheme = "comgooglemaps://?\(locationName)&center=\(coordinate.latitude),\(coordinate.longitude)&zoom=10"
            open(url: googleUrlScheme)
            
        case .appleMaps:
            let appleUrlScheme = "http://maps.apple.com/?\(locationName)&ll=\(coordinate.latitude),\(coordinate.longitude)&z=10"
            open(url: appleUrlScheme)
        }
    }
    
}


// MARK: - Private - Open by URL
private extension NativeMapsHandler {
    
    func open(url: String) {
        guard let customUrl = URL(string: url) else { return }
        
        if UIApplication.shared.canOpenURL(customUrl) {
            UIApplication.shared.open(customUrl, options: [:], completionHandler: nil)
            
        } else {
            let message = "Google maps not installed. Download Google Maps from App Store and try again."
            AlertViewPresenter.shared.presentError(withMessage: message)
        }
    }
}
