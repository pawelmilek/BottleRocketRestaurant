//
//  RestaurantDetailMapView.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class RestaurantDetailMapView: UIView {
    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var openMapDirectionButton: UIButton!
    @IBOutlet weak var showDetailsButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    
    weak var delegate: RestaurantDetailMapViewDelegate?
    var restaurant: Restaurant? {
        didSet {
            guard let restaurant = restaurant else { return }
            nameLabel.text = restaurant.name
            streetLabel.text = restaurant.location.street
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setupStyle()
    }
    
    // MARK: - Hit test. We need to override this to detect hits in our custom callout.
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Check if it hit our annotation detail view components.
        if let result = openMapDirectionButton.hitTest(convert(point, to: openMapDirectionButton), with: event) {
            return result
        }
        
        if let result = showDetailsButton.hitTest(convert(point, to: showDetailsButton), with: event) {
            return result
        }
        
        // fallback to our background content view
        return contentButton.hitTest(convert(point, to: contentButton), with: event)
    }
}


// MARK: - ViewSetupable protocol
extension RestaurantDetailMapView: ViewSetupable {
    
    func setup() {
        self.layer.cornerRadius = 10
    }
    
    func setupStyle() {
        typealias DetailMapViewStyle = Style.RestaurantDetailMapView
        backgroundColor = DetailMapViewStyle.defaultBackgroundColor
        
        nameLabel.font = DetailMapViewStyle.nameLabelFont
        nameLabel.textColor = DetailMapViewStyle.nameLabelTextColor
        nameLabel.textAlignment = DetailMapViewStyle.nameLabelAlignment
        nameLabel.numberOfLines = DetailMapViewStyle.nameLabelNumberOfLines

        streetLabel.font = DetailMapViewStyle.streetLabelFont
        streetLabel.textColor = DetailMapViewStyle.streetLabelTextColor
        streetLabel.textAlignment = DetailMapViewStyle.streetLabelAlignment
        streetLabel.numberOfLines = DetailMapViewStyle.streetLabelNumberOfLines
    }
    
}


// MARK: Configure
extension RestaurantDetailMapView {
    
    func configure(by restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
}


// MARK: - Actions
extension RestaurantDetailMapView {
    
    @IBAction func showDetailsButtonPressed(_ sender: UIButton) {
        delegate?.restaurantDetailMapView(self, didPressShowDetails: sender)
    }
    
    @IBAction func openMapsButtonPressed(_ sender: UIButton) {
        delegate?.restaurantDetailMapView(self, didPressOpenMpasDirection: sender)
    }
    
}
