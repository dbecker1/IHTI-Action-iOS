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
    @IBOutlet weak var imageViewContainer: UIImageView!
    
    
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        let camera = GMSCameraPosition.camera(withLatitude: 33.77,
                                                          longitude: -84.39, zoom: 10)
        mapView.camera = camera
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.addSubview(pageViewContainer)
        
        let services = GooglePlacesService(delegate: self)
        services.loadBusinesses()
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
            
        }
    }
}

extension MapViewController : GooglePlacesDelegate {
    func foundBusinesses(businesses: [Business]) {
        print(businesses)
        
        // Here instantiate the PageViewController with the array of businesses
    }
}
