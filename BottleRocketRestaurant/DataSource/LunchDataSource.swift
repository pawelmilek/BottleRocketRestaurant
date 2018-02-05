//
//  LunchDataSource.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

final class LunchDataSource: NSObject, LunchDataSourceDelegate, UserInterfaceCheckable {
    weak var delegatorVC: UIViewController?
    
    var items: [Restaurant]?
    
    init(items: [Restaurant]?, delegatorVC: UIViewController?) {
        self.items = items
        self.delegatorVC = delegatorVC
    }
}



// MARK: - UICollectionViewDataSource protocol
extension LunchDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cell: RestaurantCollectionViewCell.self, for: indexPath)
        let restaurantItem = item(at: indexPath)
        cell.configure(by: restaurantItem)
        
        return cell
    }
    
}


// MARK: - UICollectionViewDelegate protocol
extension LunchDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        delegatorVC?.performSegue(withIdentifier: SegueIdentifierType.segueRestaurantDetails.rawValue, sender: indexPath)
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout protocol
extension LunchDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = isPad ? 2 : 1
        let viewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        viewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        viewFlowLayout.minimumLineSpacing = 0
        viewFlowLayout.minimumInteritemSpacing = 0
        
        let sectionInsets = viewFlowLayout.sectionInset.left + viewFlowLayout.sectionInset.right
        let totalSpace = sectionInsets + (viewFlowLayout.minimumInteritemSpacing * CGFloat(numberOfColumns - 1))
        
        let width = Int((collectionView.bounds.width - totalSpace) / numberOfColumns)
        let height = 180
        
        return CGSize(width: width, height: height)
    }
    
}
