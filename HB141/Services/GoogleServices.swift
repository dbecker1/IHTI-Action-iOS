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
            let x = GoogleConstants.businessCount
            let y = (placeList?.likelihoods.count)!
            let maxIndex = min(x, y) - 1
            if let placeList = placeList {
                for i in 0...maxIndex {
                    let place = placeList.likelihoods[i]
                    let business = Business()
                    business.businessName = place.place.name.capitalized
                    var types = place.place.types
                    if let estIndex = types.index(of: "establishment") {
                        types.remove(at: estIndex)
                    }
                    business.businessType = types.joined(separator: " | ").capitalized.replacingOccurrences(of: "_", with: " ")
                    business.placeID = place.place.placeID
                    business.businessAddress = place.place.formattedAddress
                    business.businessPhone = place.place.phoneNumber
                    business.businessWebsite = place.place.website?.absoluteString
                    business.location = place.place.coordinate
                    self.businesses.append(business)
                    print("\(business.businessName!)")
                }
            }
            
            self.loadImages(index: 0, maxIndex: maxIndex)
        }

    }
    
    func loadImages(index : Int, maxIndex: Int) {
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
                        
                        if(index == maxIndex) {
                            self.delegate.foundBusinesses(businesses: self.businesses)
                        } else {
                            let newIndex = index + 1
                            if (newIndex == 19) {
                                print("here")
                            }
                            self.loadImages(index: newIndex, maxIndex: maxIndex)
                        }
                    })
                } else {
                    if(index == GoogleConstants.businessCount - 1) {
                        self.delegate.foundBusinesses(businesses: self.businesses)
                    } else {
                        let newIndex = index + 1
                        self.loadImages(index: newIndex, maxIndex: maxIndex)
                    }
                }
            }
            
        }
    }
}

protocol GooglePlacesDelegate {
    func foundBusinesses(businesses : [Business])
}
