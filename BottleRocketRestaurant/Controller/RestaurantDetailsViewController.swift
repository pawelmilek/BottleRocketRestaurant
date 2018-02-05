//
//  LunchDetailsViewController.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RestaurantDetailsViewController: UIViewController, CLLocationManagerDelegate {
    typealias RestaurantDetails = Restaurant
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameAndCategoryView: UIView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var categoryTypeLabel: UILabel!
    @IBOutlet weak var formattedAddressLabel: UILabel!
    @IBOutlet weak var formattedPhoneLabel: UILabel!
    @IBOutlet weak var twitterHandlerLabel: UILabel!
    
    var details: RestaurantDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupStyle()
        zoomInAnnotation()
    }
    
}


// MARK: - ViewSetupable protocol
extension RestaurantDetailsViewController: ViewSetupable {
    
    func setup() {
        setDelegate()
        dropPinAtRestaurantLocation()
        setDefaultValueForLabels()
        setData()
    }
    
    func setupStyle() {
        setNavigationBar()
        renderLabelsStyle()
    }
    
}


// MARK: - Private - Set data
private extension RestaurantDetailsViewController {
    
    func setDelegate() {
        mapView.delegate = self
    }
    
}


// MARK: - Private - Set data
private extension RestaurantDetailsViewController {
    
    func setData() {
        guard let details = details else {
            setDefaultValueForLabels()
            return
        }
        
        restaurantNameLabel.text = details.name
        categoryTypeLabel.text = details.category.description
        formattedAddressLabel.text = details.location.completeAddress
        formattedPhoneLabel.text = details.contact?.formattedPhone
        twitterHandlerLabel.text = details.contact?.twitter
    }
    
}

// MARK: - Private - Set navigation bar
private extension RestaurantDetailsViewController {
    
    func setNavigationBar() {
        self.title = "Lunch Tyme"
    }
    
}


// MARK: - Private - Set labels
private extension RestaurantDetailsViewController {
    
    func setDefaultValueForLabels() {
        restaurantNameLabel.text = ""
        categoryTypeLabel.text = ""
        formattedAddressLabel.text = ""
        formattedPhoneLabel.text = ""
        twitterHandlerLabel.text = ""
    }
    
    func renderLabelsStyle() {
        typealias RestaurantDetailsStyle = Style.RestaurantDetailsVC
        nameAndCategoryView.backgroundColor = .darkMint
        
        restaurantNameLabel.font = RestaurantDetailsStyle.restaurantNameLabelFont
        restaurantNameLabel.textColor = RestaurantDetailsStyle.restaurantNameLabelTextColor
        restaurantNameLabel.textAlignment = RestaurantDetailsStyle.restaurantNameLabelAlignment
        restaurantNameLabel.numberOfLines = RestaurantDetailsStyle.restaurantNameLabelNumberOfLines
        
        categoryTypeLabel.font = RestaurantDetailsStyle.categoryTypeLabelFont
        categoryTypeLabel.textColor = RestaurantDetailsStyle.categoryTypeLabelTextColor
        categoryTypeLabel.textAlignment = RestaurantDetailsStyle.categoryTypeLabelAlignment
        categoryTypeLabel.numberOfLines = RestaurantDetailsStyle.categoryTypeLabelNumberOfLines
        
        formattedAddressLabel.font = RestaurantDetailsStyle.formattedAddressLabelFont
        formattedAddressLabel.textColor = RestaurantDetailsStyle.formattedAddressLabelTextColor
        formattedAddressLabel.textAlignment = RestaurantDetailsStyle.formattedAddressLabelAlignment
        formattedAddressLabel.numberOfLines = RestaurantDetailsStyle.formattedAddressLabelNumberOfLines
        
        formattedPhoneLabel.font = RestaurantDetailsStyle.formattedPhoneLabelFont
        formattedPhoneLabel.textColor = RestaurantDetailsStyle.formattedPhoneLabelTextColor
        formattedPhoneLabel.textAlignment = RestaurantDetailsStyle.formattedPhoneLabelAlignment
        formattedPhoneLabel.numberOfLines = RestaurantDetailsStyle.formattedPhoneLabelNumberOfLines
        
        twitterHandlerLabel.font = RestaurantDetailsStyle.twitterHandlerLabelFont
        twitterHandlerLabel.textColor = RestaurantDetailsStyle.twitterHandlerLabelTextColor
        twitterHandlerLabel.textAlignment = RestaurantDetailsStyle.twitterHandlerLabelAlignment
        twitterHandlerLabel.numberOfLines = RestaurantDetailsStyle.twitterHandlerLabelNumberOfLines
    }
}


// MARK: - Private - Create place addnotation
private extension RestaurantDetailsViewController {
    
    func dropPinAtRestaurantLocation() {
        guard let restaurant = details else { return }
        
        let annotation = RestaurantAnnotation(restaurant: restaurant)
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
    }
    
    func zoomInAnnotation() {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
}


// MARK: - MKMapViewDelegate protocol
extension RestaurantDetailsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let pinIdentifier = "pinIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdentifier) as? RestaurantAnnotationView
        
        if annotationView == nil {
            annotationView = RestaurantAnnotationView(annotation: annotation, reuseIdentifier: pinIdentifier)
            annotationView!.isHiddenShowDetailsButton = true
            annotationView!.restaurantDetailDelegate = self
            
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        guard let annotation = mapView.annotations.last else { return }
        mapView.selectAnnotation(annotation, animated: true)
    }
    
}


// MARK: - RestaurantDetailMapViewDelegate protocol
extension RestaurantDetailsViewController: RestaurantDetailMapViewDelegate {
    
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

}


// MARK: - Private - Open in Apple Mpas
private extension RestaurantDetailsViewController {
    
    func openInAppleMpas(mapsData: (coordinate: Coordinate, locationName: String)) {
        NativeMapsHandler.appleMaps.open(at: mapsData.coordinate, withLocationName: mapsData.locationName)
    }
    
}

