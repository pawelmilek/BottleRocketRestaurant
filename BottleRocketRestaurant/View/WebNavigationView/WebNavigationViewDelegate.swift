//
//  WebNavigationViewDelegate.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

protocol WebNavigationViewDelegate: class {
    func webNavigationView(_ webNavigationView: WebNavigationView, didSelectBackButton: UIButton)
    func webNavigationView(_ webNavigationView: WebNavigationView, didSelectRefreshButton: UIButton)
    func webNavigationView(_ webNavigationView: WebNavigationView, didSelectForwardButton: UIButton)
}
