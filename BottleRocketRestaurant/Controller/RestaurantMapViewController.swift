//
//  RestaurantMapViewController.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RestaurantMapViewController: UIViewController, UserInterfaceCheckable {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchBar: RestaurantSearchBar!
    @IBOutlet weak var listMapButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    private var isListView = false
    private var isSearchBarActive = false
    private var dataSource: RestaurantMapDataSourceDelegate?
    private var allAnnotations: [MKAnnotation] = []
    
    var restaurants: [Restaurant] = [] {
        didSet {
            dataSource?.items = restaurants
            reloadData()
        }
    }
    
    private var filteredRestaurants: [Restaurant] = []  {
        didSet {
            dataSource?.items = filteredRestaurants
            reloadData()
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
    
    deinit {
        unregisterNotification()
    }
}


// MARK: - ViewSetupable protocol
extension RestaurantMapViewController: ViewSetupable {
    
    func setup() {
        setNavigationBar()
        setSearchBar()
        setTableView()
        setMapView()
        registerNotification()
    }
    
    func setupStyle() {
        setStatusBar()
        setListMapButton()
    }
    
}


// MARK: - Private - Set search controller
private extension RestaurantMapViewController {
    
    func setNavigationBar() {
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: Style.NavigationBar.titleFont,
                                             NSAttributedStringKey.foregroundColor: Style.NavigationBar.tintColor]
        navigationBar.topItem?.title = "Lunch Tyme"
    }
    
    func setSearchBar() {
        searchBar.delegate = self
    }
    
    func setTableView() {
        tableView.register(cell: RestaurantMapTableViewCell.self)
        dataSource = RestaurantMapDataSource(items: restaurants)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
    }
    
    func setMapView() {
        mapView.delegate = self
        renderMapView()
        dropAllRestaurantPins()
        zoomInAnnotations()
    }
    
    func setListMapButton() {
        listMapButton.backgroundColor = Style.ListMapButton.backgroundColor
        listMapButton.setTitleColor(Style.ListMapButton.titleColor, for: .normal)
        listMapButton.titleLabel?.font = Style.ListMapButton.titleFont
    }
    
    func setStatusBar() {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor.mint
        view.addSubview(statusBarView)
    }
    
}


// MARK: - Private - Render List and Map view
private extension RestaurantMapViewController {
    
    func renderListView() {
        listMapButton.setTitle("Map", for: .normal)
        isListView = true
        
        tableView.alpha = 0
        mapView.alpha = 1
        UIView.animate(withDuration: 0.4) {
            self.tableView.alpha = 1
            self.mapView.alpha = 0
        }
        
        filter(for: "")
        searchBar.resignFirstResponder()
        reloadData()
    }
    
    func renderMapView() {
        listMapButton.setTitle("List", for: .normal)
        isListView = false
        
        tableView.alpha = 1
        mapView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.tableView.alpha = 0
            self.mapView.alpha = 1
        }
    }
}


// MARK: - Add Notification Observer
extension RestaurantMapViewController {
    
    func registerNotification() {
        addMapAnnotationSelectedNofificationObserver()
    }
    
    func unregisterNotification() {
        removeMapAnnotationSelectedNofificationObserver()
    }
    
    
    func addMapAnnotationSelectedNofificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(annotationSelected(_:)),
                                               name: NotificationKey.mapAnnotationSelected.name, object: nil)
    }
    
    func removeMapAnnotationSelectedNofificationObserver() {
        NotificationCenter.default.removeObserver(self, name: NotificationKey.mapAnnotationSelected.name, object: nil)
    }
    
    
    @objc func annotationSelected(_ notification: NSNotification) {
        guard let currentRestaurant = notification.userInfo?[NotificationUserInfoKey.mapAnnotationSelected.rawValue] as? Restaurant else { return }
        let latitude = currentRestaurant.location.coordinate.latitude
        let longitude = currentRestaurant.location.coordinate.longitude
        
        let currentAnnotation = allAnnotations.filter {
            let location: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
            return $0.coordinate.latitude == location.coordinate.latitude && $0.coordinate.longitude == location.coordinate.longitude
        }
        
        guard let annotation = currentAnnotation.first else {
            Logger.log(message: "Selected annotation for \(currentRestaurant.name) not available", event: .error)
            return
        }
        
        searchBarCancelButtonClicked(searchBar)
        renderMapView()
        mapView.showAnnotations([annotation], animated: true)
        mapView.selectAnnotation(annotation, animated: true)
    }
    
}


// MARK: - Private - Filter list
private extension RestaurantMapViewController {
    
    var isFiltering: Bool {
        return isSearchBarActive && !searchBar.isEmpty
    }
    
    func filter(for searchText: String) {
        guard isFiltering else {
            filteredRestaurants = restaurants
            return
        }
        filteredRestaurants = restaurants.filter { (restaurant: Restaurant) -> Bool in
            let searchingText = searchText.lowercased()
            let searchInText = (restaurant.location.completeAddress + " " + restaurant.name).lowercased()
            return searchInText.contains(searchingText)
        }
        
        reloadData()
    }
    
}


// MARK: - Private - Reload/Refresh data
private extension RestaurantMapViewController {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


// MARK: - Private - Create place addnotation
private extension RestaurantMapViewController {
    
    func dropAllRestaurantPins() {
        restaurants.forEach {
            let annotation = RestaurantAnnotation(restaurant: $0)
            allAnnotations.append(annotation)
        }
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(allAnnotations)
    }
    
    func zoomInAnnotations() {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
}


// MARK: - MKMapViewDelegate protocol
extension RestaurantMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let pinIdentifier = "pinIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdentifier) as? RestaurantAnnotationView
        
        if annotationView == nil {
            annotationView = RestaurantAnnotationView(annotation: annotation, reuseIdentifier: pinIdentifier)
            annotationView!.restaurantDetailDelegate = self
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
}


// MARK: - UISearchBarDelegate protocol
extension RestaurantMapViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearchBarActive = true
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearchBarActive = false
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if isListView == false {
            renderListView()
            searchBar.becomeFirstResponder()
        }
        filter(for: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filter(for: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        isSearchBarActive = false
        searchBar.text = ""
        filter(for: searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
}


// MARK: - RestaurantDetailMapViewDelegate protocol
extension RestaurantMapViewController: RestaurantDetailMapViewDelegate {
    
    func restaurantDetailMapView(_ restaurantDetailMapView: RestaurantDetailMapView, didPressOpenMpasDirection button: UIButton) {
        var mapsData: (coordinate: Coordinate, locationName: String) {
            guard let restaurant = restaurantDetailMapView.restaurant else {
                AlertViewPresenter.shared.presentError(withMessage: "Restaurant position is not available")
                return (coordinate: Coordinate(latitude: 0, longitude: 0), locationName: "")
            }
            
            let coordinate = restaurant.location.coordinate
            let name = restaurant.name
            return (coordinate: coordinate, locationName: name)
        }
        
        openInAppleMpas(mapsData: mapsData)
    }
    
    
    func restaurantDetailMapView(_ restaurantDetailMapView: RestaurantDetailMapView, didPressShowDetails button: UIButton) {
        showPopover(base: button, with: restaurantDetailMapView.restaurant)
    }

}


// MARK: - Show Restaurant details ViewController as popover
extension RestaurantMapViewController {
    
    func showPopover(base: UIView, with restaurant: Restaurant?) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RestaurantDetailsViewController") as? RestaurantDetailsViewController {
            viewController.details = restaurant
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .popover
            
            if let popoverPresentationController = navigationController.popoverPresentationController {
                popoverPresentationController.delegate = self
                popoverPresentationController.sourceView = base
                popoverPresentationController.sourceRect = base.bounds
                self.present(navigationController, animated: true)
            }
        }
    }
    
}


// MARK: - Private - Open in Apple Mpas
private extension RestaurantMapViewController {
    
    func openInAppleMpas(mapsData: (coordinate: Coordinate, locationName: String)) {
        NativeMapsHandler.appleMaps.open(at: mapsData.coordinate, withLocationName: mapsData.locationName)
    }
    
}


// MARK: - UIPopoverPresentationControllerDelegate protocol
extension RestaurantMapViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
}


// MARK: - Private - Actions
private extension RestaurantMapViewController {
    
    @IBAction func exitButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func listMapButtonPressed(_ sender: UIButton) {
        isListView = !isListView
        isListView ? renderListView() : renderMapView()
    }
    
}
