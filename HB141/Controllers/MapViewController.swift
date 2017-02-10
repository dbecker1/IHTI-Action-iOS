//
//  MapViewController.swift
//  HB141
//
//  Created by Daniel Becker on 2/9/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController : UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var pageViewContainer: UIView!
    
    
    var locationManager : CLLocationManager!
    var placesClient : GMSPlacesClient!
    
    override func viewDidLoad() {
        let camera = GMSCameraPosition.camera(withLatitude: 33.77,
                                                          longitude: -84.39, zoom: 10)
        mapView.camera = camera
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.addSubview(pageViewContainer)
        
        placesClient = GMSPlacesClient.shared()
    }
    
    func getPlaces() {
        placesClient.currentPlace() { (placeList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            var businesses = [Business]()
            if let placeList = placeList {
                for place in placeList.likelihoods {
                    let business = Business()
                    business.businessName = place.place.name
                    business.businessType = place.place.types.first
                    // TODO: Add business image
                    businesses.append(business)
                    print("\(business.businessName!)")
                }
            }
        }
        // TODO: Instantiate BusinessPageViewController with the array of businesses and then create a ViewController page for the first 5 or so 
    }
}


// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            locationManager.stopUpdatingLocation()
            
            getPlaces()
        }
    }
    
}
