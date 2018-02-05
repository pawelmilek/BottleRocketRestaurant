//
//  Style.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

struct Style {
    
    // MARK: - NavigationBar
    struct NavigationBar {
        static let titleFont = UIFont(name: "AvenirNext-DemiBold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .bold)
        static let tintColor = UIColor.white
        static let backgroundColor = UIColor.mint
    }
    
    
    // MARK: - TabBar
    struct TabBar {
        static let backgroundColor = UIColor.charcoal
        static let tintColor = UIColor.white
    }
    
    
    // MARK: - RestaurantSearchBar
    struct RestaurantSearchBar {
        static var searchBarBackgroundColor = UIColor.mint
        static let searchBarCancelButtonFont = UIFont.init(name: "AvenirNext-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .light)
        static let searchBarCancelButtonColor = UIColor.white
        static let searchBarCancelButtonBackgroundColor = UIColor.white
        
        static let searchTextFieldBackgroundColor = UIColor.white
        static let searchTextFieldFont = UIFont.init(name: "AvenirNext-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .light)
        static let searchTextFieldColor = UIColor.black
        static let searchTextFieldPlaceholder = UIColor.gray
        static var searchTextFieldTintColor = UIColor.darkMint
        static let textFieldClearButtonColor = UIColor.gray
        static let glassIconColor = UIColor.gray
    }
    
    
    // MARK: ListMapButton
    struct ListMapButton {
        static let titleFont = UIFont.init(name: "AvenirNext-DemiBold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
        static let titleColor = UIColor.white
        static let backgroundColor = UIColor.mint
    }
    
    // MARK: - AvailabilityMessageView
    struct AvailabilityMessageView {
        static let titleLabelTextAlignment = NSTextAlignment.center
        static let titleLabelFont = UIFont(name: "AvenirNext-DemiBold", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        static let subTitleLabelFont = UIFont(name: "AvenirNext-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .light)
        static let subTitleLabelTextAlignment = NSTextAlignment.center
    }
    
    
    
    // MARK: - LunchViewController
    struct LunchVC {
        static let peripheralNameLabelFont = UIFont.systemFont(ofSize: 25, weight: .regular)
        static let peripheralNameLabelNumberOfLines = 1
        static let peripheralNameLabelAlignment = NSTextAlignment.left
        
        static let peripheralUUIDLabelFont = UIFont.systemFont(ofSize: 16, weight: .ultraLight)
        static let peripheralUUIDLabelNumberOfLines = 1
        static let peripheralUUIDLabelAlignment = NSTextAlignment.left
        
        static let connectedLabelFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let connectedLabelTextColor = UIColor.red
        static let connectedLabelNumberOfLines = 1
        static let connectedLabelAlignment = NSTextAlignment.left
    }
    
    
    // MARK: - RestaurantDetailsViewController
    struct RestaurantDetailsVC {
        static let defaultBackgroundColor = UIColor.white
        static let nameAndCategoryViewBackgroundColor = UIColor.darkMint
        
        static let restaurantNameLabelFont = UIFont(name: "AvenirNext-DemiBold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        static let restaurantNameLabelTextColor = UIColor.white
        static let restaurantNameLabelAlignment = NSTextAlignment.left
        static let restaurantNameLabelNumberOfLines = 1
        
        static let categoryTypeLabelFont = UIFont(name: "AvenirNext-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        static let categoryTypeLabelTextColor = UIColor.white
        static let categoryTypeLabelAlignment = NSTextAlignment.left
        static let categoryTypeLabelNumberOfLines = 1
        
        static let formattedAddressLabelFont = UIFont(name: "AvenirNext-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
        static let formattedAddressLabelTextColor = UIColor.black
        static let formattedAddressLabelAlignment = NSTextAlignment.left
        static let formattedAddressLabelNumberOfLines = 0
        
        static let formattedPhoneLabelFont = UIFont(name: "AvenirNext-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
        static let formattedPhoneLabelTextColor = UIColor.black
        static let formattedPhoneLabelAlignment = NSTextAlignment.left
        static let formattedPhoneLabelNumberOfLines = 1
        
        static let twitterHandlerLabelFont = UIFont(name: "AvenirNext-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
        static let twitterHandlerLabelTextColor = UIColor.black
        static let twitterHandlerLabelAlignment = NSTextAlignment.left
        static let twitterHandlerLabelNumberOfLines = 1
    }
    
    
    // MARK: - RestaurantCollectionViewCell
    struct RestaurantCell {
        static let defaultBackgroundColor = UIColor.white
        
        static let restaurantNameLabelFont = UIFont(name: "AvenirNext-DemiBold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        static let restaurantNameLabelTextColor = UIColor.white
        static let restaurantNameLabelAlignment = NSTextAlignment.left
        static let restaurantNameLabelNumberOfLines = 1
        
        static let categoryTypeLabelFont = UIFont(name: "AvenirNext-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        static let categoryTypeLabelTextColor = UIColor.white
        static let categoryTypeLabelAlignment = NSTextAlignment.left
        static let categoryTypeLabelNumberOfLines = 1
    }
    
    // MARK: RestaurantMapTableViewCell
    struct RestaurantMapCell {
        static let defaultBackgroundColor = UIColor.white
        
        static let nameLabelFont = UIFont(name: "AvenirNext-DemiBold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        static let nameLabelTextColor = UIColor.black
        static let nameLabelAlignment = NSTextAlignment.left
        static let nameLabelNumberOfLines = 1
        
        static let addressLabelFont = UIFont(name: "AvenirNext-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        static let addressLabelTextColor = UIColor.black
        static let addressLabelAlignment = NSTextAlignment.left
        static let addressLabelNumberOfLines = 1
    }
    
    // MARK: RestaurantDetailMapView
    struct RestaurantDetailMapView {
        static let defaultBackgroundColor = UIColor.white
        
        static let nameLabelFont = UIFont(name: "AvenirNext-DemiBold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
        static let nameLabelTextColor = UIColor.darkMint
        static let nameLabelAlignment = NSTextAlignment.left
        static let nameLabelNumberOfLines = 1
        
        static let streetLabelFont = UIFont(name: "AvenirNext-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        static let streetLabelTextColor = UIColor.black
        static let streetLabelAlignment = NSTextAlignment.left
        static let streetLabelNumberOfLines = 1
        
    }
    
}
