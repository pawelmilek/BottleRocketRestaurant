//
//  LunchViewController.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

class LunchViewController: UIViewController, UserInterfaceCheckable {
    @IBOutlet weak var restaurantCollectionView: UICollectionView!
    
    private lazy var refreshController: UIRefreshControl = {
        let refreshCtr = UIRefreshControl()
        refreshCtr.tintColor = .mint
        refreshCtr.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        return refreshCtr
    }()
    
    private var shouldShowActivityIndicatorOnce = true
    private var dataSource: LunchDataSourceDelegate?
    private var restaurants: [Restaurant] = [] {
        didSet {
            dataSource?.items = restaurants
            reloadRestaurantsData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupStyle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifierType.segueRestaurantDetails.rawValue {
            guard let destination = segue.destination as? RestaurantDetailsViewController else {
                Logger.log(message: "Restaurant details destination not available", event: .error)
                return
            }
            
            guard let selectedIndexPath = sender as? IndexPath else {
                Logger.log(message: "Restaurant details index path not available", event: .error)
                return
            }
            
            let selectedRestaurant = restaurants[selectedIndexPath.row]
            destination.details = selectedRestaurant
            print(SegueIdentifierType.segueRestaurantDetails.rawValue + "Selected at: \(selectedRestaurant.name)")
            
        } else if segue.identifier == SegueIdentifierType.segueRestaurantMap.rawValue {
            guard let destination = segue.destination as? RestaurantMapViewController else {
                Logger.log(message: "Restaurants map destination not available", event: .error)
                return
            }
            
            destination.restaurants = restaurants
        }
    }
}


// MARK: - ViewSetupable protocol
extension LunchViewController: ViewSetupable {
    
    func setup() {
        setCollectionView()
        setDelegates()
        fetchData()
    }
    
    func setupStyle() {
        setNavigationBar()
    }
}


// MARK: - Set collection view
private extension LunchViewController {
    
    func setCollectionView() {
        func setRefreshController() {
            restaurantCollectionView.refreshControl = refreshController
            restaurantCollectionView.alwaysBounceVertical = true
        }
        
        restaurantCollectionView.register(cell: RestaurantCollectionViewCell.self)
        restaurantCollectionView.backgroundColor = .ultraLightGray
        setRefreshController()
    }

}


// MARK: - Set delegates
private extension LunchViewController {
    
    func setDelegates() {
        dataSource = LunchDataSource(items: restaurants, delegatorVC: self)
        restaurantCollectionView.dataSource = dataSource
        restaurantCollectionView.delegate = dataSource
    }
}


// MARK: - Fetch data
private extension LunchViewController {
    
    @objc func fetchData() {
        showActivityIndicator()
        
        WebService.shared.requestRestaurantsData {[weak self] result in
            guard let strongSelf = self else {
                Logger.log(message: "Could not store weak self reference", event: .error)
                return
            }
            
            switch result {
            case .success(let data):
                strongSelf.restaurants = data.restaurants
                
            case .failure(let error):
                strongSelf.restaurants = []
                error.handle()
            }
            
            strongSelf.hideRefreshController()
            strongSelf.hideActivityIndicator()
        }
    }
}


// MARK: - Set navigation bar
private extension LunchViewController {
    
    func setNavigationBar() {
        func setTitle() {
            typealias NavigationBarStyle = Style.NavigationBar
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: NavigationBarStyle.titleFont,
                                                                       NSAttributedStringKey.foregroundColor: NavigationBarStyle.tintColor]
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.topItem?.title = "Lunch Tyme"
        }
        
        func setShadowUnderNavigationBar() {
            navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
            navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 2, height: 2)
            navigationController?.navigationBar.layer.shadowRadius = 4
            navigationController?.navigationBar.layer.shadowOpacity = 1
        }
        
        setTitle()
        setShadowUnderNavigationBar()
    }
}


// MARK: - Private - Reload/Refresh data
private extension LunchViewController {
    
    func reloadRestaurantsData() {
        DispatchQueue.main.async {
            self.restaurantCollectionView.reloadData()
            self.renderNoDataAvailableMessage()
        }
    }
    
    func hideRefreshController() {
        DispatchQueue.main.async {
            self.refreshController.endRefreshing()
        }
    }
    
    func showActivityIndicator() {
        if shouldShowActivityIndicatorOnce {
            ActivityIndicator.shared.startAnimating(at: view)
        }
    }
    
    func hideActivityIndicator() {
        if shouldShowActivityIndicatorOnce {
            ActivityIndicator.shared.stopAnimating()
            shouldShowActivityIndicatorOnce = false
        }
    }
}


// MARK: - Private - Show/Hide No data available message
private extension LunchViewController {
    
    func renderNoDataAvailableMessage() {
        var shouldShowMessage: Bool {
            return dataSource?.numberOfItems == 0 ? true : false
        }
        
        if shouldShowMessage {
            let title = "No restaurants available"
            let subtitle = "Push to refresh"
            AvailabilityMessageView.show(on: restaurantCollectionView, title: title, subtitle: subtitle)
        } else {
            AvailabilityMessageView.hide()
        }
    }
    
}
