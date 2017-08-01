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
    
    static func loadBusinesses(foundBusinesses: @escaping (([String]) -> Void), page : Int = 1) {
        let businessProvider = BusinessProvider.shared
        let placesClient = GMSPlacesClient.shared()
        placesClient.currentPlace() { (placeList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            let x = GoogleConstants.businessCount
            let y = (placeList?.likelihoods.count)!
            var maxIndex = min(x, y) - 1
            if let placeList = placeList {
                var i = 0
                while i < maxIndex {
                    let place = placeList.likelihoods[i]
                    let filter = place.place.types.filter() { GoogleConstants.applicablePlaces.contains($0) }
                    if filter.count == 0 {
                        maxIndex = min(maxIndex + 1, placeList.likelihoods.count)
                        i = i + 1
                        continue
                    }
                    let business = Business(place: place)
                    businessProvider.addBusiness(newBusiness: business)
                    i = i + 1
                }
            }
            
            foundBusinesses(businessProvider.getBusinessIds())
        }

    }
    
    static func loadImage(forId businessId: String) {
        let placesClient = GMSPlacesClient.shared()
        print("Loading image for business: \(businessId)")
        placesClient.lookUpPhotos(forPlaceID: businessId) {
            (photos, error) -> Void in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    placesClient.loadPlacePhoto(firstPhoto) {
                        (image, e) -> Void in
                        if let e = e {
                            print("Error loading image: \(e.localizedDescription)")
                        } else {
                            BusinessProvider.shared.updateImage(forId: businessId, newImage: image)
                        }
                    }
                }
            }
        }
    }
    
}
