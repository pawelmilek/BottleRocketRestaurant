//
//  RestaurantMapTableViewCell.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class RestaurantMapTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressFirstLineLabel: UILabel!
    @IBOutlet weak var addressSecondLineLabel: UILabel!
    
    private var restaurant: Restaurant? {
        didSet {
            guard let restaurant = restaurant else { return }
        
            nameLabel.text = restaurant.name
            addressFirstLineLabel.text = restaurant.location.street
            addressSecondLineLabel.text = restaurant.location.city + ", " + restaurant.location.state + " " + (restaurant.location.zipcode ?? "")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setupStyle()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setup()
    }
}

// MARK: - ViewSetupable protocol
extension RestaurantMapTableViewCell: ViewSetupable {
    
    func setup() {
        nameLabel.text = ""
        addressFirstLineLabel.text = ""
        addressSecondLineLabel.text = ""
    }
    
    func setupStyle() {
        typealias CellStyle = Style.RestaurantMapCell
        
        backgroundColor = CellStyle.defaultBackgroundColor
        nameLabel.font = CellStyle.nameLabelFont
        nameLabel.textColor = CellStyle.nameLabelTextColor
        nameLabel.textAlignment = CellStyle.nameLabelAlignment
        nameLabel.numberOfLines = CellStyle.nameLabelNumberOfLines
        
        addressFirstLineLabel.font = CellStyle.addressLabelFont
        addressFirstLineLabel.textColor = CellStyle.addressLabelTextColor
        addressFirstLineLabel.textAlignment = CellStyle.addressLabelAlignment
        addressFirstLineLabel.numberOfLines = CellStyle.addressLabelNumberOfLines
        
        addressSecondLineLabel.font = CellStyle.addressLabelFont
        addressSecondLineLabel.textColor = CellStyle.addressLabelTextColor
        addressSecondLineLabel.textAlignment = CellStyle.addressLabelAlignment
        addressSecondLineLabel.numberOfLines = CellStyle.addressLabelNumberOfLines
    }

}


// MARK: - Configuration
extension RestaurantMapTableViewCell {
    
    func configure(by item: Restaurant?) {
        restaurant = item
    }
    
}
