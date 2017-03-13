//
//  GoogleServices.swift
//  HB141
//
//  Created by Daniel Becker on 2/12/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import Foundation
import GooglePlaces

class GooglePlacesService : NSObject {
    
    var delegate : GooglePlacesDelegate
    var placesClient : GMSPlacesClient!
    var businesses = [Business]()
    
    init(delegate : GooglePlacesDelegate) {
        self.delegate = delegate
        self.placesClient = GMSPlacesClient.shared()
    }
    
    func loadBusinesses() {
        placesClient.currentPlace() { (placeList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            if let placeList = placeList {
                for i in 0...(GoogleConstants.businessCount - 1) {
                    let place = placeList.likelihoods.remove(at: i)
                    let business = Business()
                    business.businessName = place.place.name.capitalized
                    business.businessType = place.place.types.joined(separator: " | ").capitalized.replacingOccurrences(of: "_", with: " ")
                    business.placeID = place.place.placeID
                    business.businessAddress = place.place.formattedAddress
                    business.businessPhone = place.place.phoneNumber
                    business.businessWebsite = place.place.website?.absoluteString
                    self.businesses.append(business)
                    print("\(business.businessName!)")
                }
            }
            
            self.loadImages(index: 0)
        }

    }
    
    func loadImages(index : Int) {
        let business = businesses[index]
        placesClient.lookUpPhotos(forPlaceID: business.placeID!) { (photos, error) -> Void in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.placesClient.loadPlacePhoto(firstPhoto, callback: {
                        (image, e) -> Void in
                        if let e = e {
                            print("Error: \(e.localizedDescription)")
                        } else {
                            business.image = image;
                        }
                        if(index == GoogleConstants.businessCount - 1) {
                            self.delegate.foundBusinesses(businesses: self.businesses)
                        } else {
                            let newIndex = index + 1
                            self.loadImages(index: newIndex)
                        }
                    })
                } else {
                    if(index == GoogleConstants.businessCount - 1) {
                        self.delegate.foundBusinesses(businesses: self.businesses)
                    } else {
                        let newIndex = index + 1
                        self.loadImages(index: newIndex)
                    }
                }
            }
            
        }
    }
}

protocol GooglePlacesDelegate {
    func foundBusinesses(businesses : [Business])
}
