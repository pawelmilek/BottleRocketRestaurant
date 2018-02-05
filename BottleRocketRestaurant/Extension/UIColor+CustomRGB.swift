//
//  UIColor+CustomRGB.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var mint: UIColor {
        return colorRGB(component: (red: CGFloat(67), green: CGFloat(232), blue: CGFloat(149)))
    }
    
    static var darkMint: UIColor {
        return colorRGB(component: (red: CGFloat(52), green: CGFloat(179), blue: CGFloat(121)))
    }
    
    static var charcoal: UIColor {
        return colorRGB(component: (red: CGFloat(31), green: CGFloat(31), blue: CGFloat(41)))
    }
    
    static var ultraLightGray: UIColor {
        return UIColor.colorRGB(component: (red: CGFloat(235), green: CGFloat(235), blue: CGFloat(241)))
    }

    static private func colorRGB(component: (red: CGFloat, green: CGFloat, blue: CGFloat), alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: component.red/255, green: component.green/255, blue: component.blue/255, alpha: alpha)
    }
    
}
