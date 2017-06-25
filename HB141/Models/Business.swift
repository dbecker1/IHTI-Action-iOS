//
//  Business.swift
//  HB141
//
//  Created by Daniel Becker on 2/9/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import GooglePlaces

class Business : NSObject {
    init(place: GMSPlaceLikelihood) {
        self.businessName = place.place.name.capitalized
        var types = place.place.types
        if let estIndex = types.index(of: "establishment") {
            types.remove(at: estIndex)
        }
        self.businessType = types.joined(separator: " | ").capitalized.replacingOccurrences(of: "_", with: " ")
        self.placeID = place.place.placeID
        self.businessAddress = place.place.formattedAddress
        self.businessPhone = place.place.phoneNumber
        self.businessWebsite = place.place.website?.absoluteString
        self.location = place.place.coordinate
        
    }
    
    var businessName : String?
    var businessType : String?
    var businessAddress : String?
    var businessPhone : String?
    var businessWebsite : String?
    var location : CLLocationCoordinate2D?
    var placeID : String?
    // I know this violates the idea of separating model from view, but it simplifies things - Daniel
    var image : UIImage?
}
