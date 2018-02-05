//
//  RestaurantCollectionViewCell.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCacheView: ImageCacheView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var categoryTypeLabel: UILabel!

    
    private var restaurant: Restaurant? {
        didSet {
            guard let restaurant = restaurant else { return }
            if let imageURL = URL(string: restaurant.backgroundImageURL) {
                imageCacheView.loadImage(from: imageURL)
            }
            
            restaurantNameLabel.text = restaurant.name
            categoryTypeLabel.text = restaurant.category.description
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
extension RestaurantCollectionViewCell: ViewSetupable {
    
    func setup() {
        restaurantNameLabel.text = ""
        categoryTypeLabel.text = ""
    }
    
    func setupStyle() {
        typealias CellStyle = Style.RestaurantCell
        
        backgroundColor = CellStyle.defaultBackgroundColor
        restaurantNameLabel.font = CellStyle.restaurantNameLabelFont
        restaurantNameLabel.textColor = CellStyle.restaurantNameLabelTextColor
        restaurantNameLabel.textAlignment = CellStyle.restaurantNameLabelAlignment
        restaurantNameLabel.numberOfLines = CellStyle.restaurantNameLabelNumberOfLines
        
        categoryTypeLabel.font = CellStyle.categoryTypeLabelFont
        categoryTypeLabel.textColor = CellStyle.categoryTypeLabelTextColor
        categoryTypeLabel.textAlignment = CellStyle.categoryTypeLabelAlignment
        categoryTypeLabel.numberOfLines = CellStyle.categoryTypeLabelNumberOfLines
        
        backgroundImageView.image = UIImage(named: "cellGradientBackground")
    }

}


// MARK: - Configuration
extension RestaurantCollectionViewCell {
    
    func configure(by item: Restaurant?) {
        restaurant = item
    }
    
}
