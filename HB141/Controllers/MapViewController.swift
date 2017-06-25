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
import FontAwesome_swift
import Toast_Swift

class MapViewController : UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var pageViewContainer: UIView!
    @IBOutlet weak var overlayView: UIView!
    
    var businessesLoaded : Bool = false
    
    var pageViewController : BusinessPageViewController?
    
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        let camera = GMSCameraPosition.camera(withLatitude: 33.77,
                                                          longitude: -84.39, zoom: 10)
        mapView.camera = camera
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        self.view.addSubview(pageViewContainer)
        self.view.bringSubview(toFront: pageViewContainer)
        
        self.title = "Choose Location"
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        navigationItem.leftBarButtonItem = BaseNavigationController.getMenuButton()
        navigationItem.backBarButtonItem = BaseNavigationController.getBackButton()
        
        if self.revealViewController() != nil {
            self.revealViewController().rearViewRevealWidth = 300
            navigationItem.leftBarButtonItem?.target = self.revealViewController()
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Embedded PageViewController") {
            self.pageViewController = segue.destination as? BusinessPageViewController
            self.pageViewController?.navController = self.navigationController
            self.pageViewController?.changeMap = self
        }
    }
    
    func showSuccessfulToast() -> Void {
        self.view.makeToast("Report Successfully Submitted.")
    }
    
    func businessesLoaded(businessIds : [String]) {
        if let pageController = pageViewController {
            pageController.setBusinesses(newBusinessIds: businessIds)
            if(overlayView != nil && view.subviews.contains(overlayView)) {
                overlayView.removeFromSuperview()
            }
            pageViewContainer.isHidden = false
        }
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
            
            if !businessesLoaded {
                businessesLoaded = true
                GooglePlacesService.loadBusinesses(foundBusinesses: businessesLoaded)
            }
        }
    }
}

extension MapViewController : MapViewChangeProtocol {
    func moveMap(to coordinate: CLLocationCoordinate2D) {
        let position = GMSCameraPosition(target: coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        mapView.animate(to: position)
        
        mapView.clear()
        
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
    }
}

protocol MapViewChangeProtocol {
    func moveMap(to coordinate: CLLocationCoordinate2D)
}
