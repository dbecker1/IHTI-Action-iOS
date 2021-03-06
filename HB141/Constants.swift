//
//  Constants.swift
//  HB141
//
//  Created by Daniel Becker on 2/6/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import Foundation
import UIKit

struct SystemConstants {
    static let debug = false
}

struct ColorConstants {
    
    static let gradientPrimary = UIColor(red: 116/255, green: 38/255, blue: 158/255, alpha: 1.0)
    
    static let gradientPrimaryDark = UIColor(red: 61/255, green: 22/255, blue: 90/255, alpha: 1.0)
    
    static let titleBarColor = UIColor(red: 115/255, green: 36/255, blue: 156/255, alpha: 1.0)
    //#9b59b6
    static let primaryColor = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1.0)
    
    //#8e44ad
    static let secondaryColor = UIColor(red: 142/255, green: 68/255, blue: 173/255, alpha: 1.0)
    
    //#FF8A65
    static let highlightColor = UIColor(red: 255/255, green: 138/255, blue: 101/255, alpha: 1.0)
    
    //#232323
    static let textColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
    
    //#FFFFFF
    static let onboarding0Color = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    
    //#606078
    static let onboarding1Color = UIColor(red: 96/255, green: 96/255, blue: 120/255, alpha: 1.0)
    
    //#786078
    static let onboarding2Color = UIColor(red: 120/255, green: 96/255, blue: 120/255, alpha: 1.0)
    
    //#A89090
    static let onboarding3Color = UIColor(red: 168/255, green: 144/255, blue: 144/255, alpha: 1.0)
    
    //#90A8A8
    static let onboarding4Color = UIColor(red: 144/255, green: 168/255, blue: 168/255, alpha: 1.0)
    
    //#90a898
    static let onboarding5Color = UIColor(red: 144/255, green: 168/255, blue: 152/255, alpha: 1.0)
    
    //#FFFFFF
    static let onboarding6Color = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 255)
}

struct GoogleConstants {
    static let mapsApiKey = "AIzaSyCz6Nc1-rEq4cyKcn2KdYb9Ck1n5_lMoFE"
    
    static let placesApiKey = "AIzaSyBs_NYH0F6kDuDHMcIEaqK_uK5Un9U7LfM"
    
    static let businessCount = 10
    
    static let dateFormat = "M/d/yy h:mm a"
    
    static let applicablePlaces = ["casino", "airport", "bus_station", "bar", "night_club", "transit_station", "train_station", "hospital", "health", "spa"]
}

struct WebConstants {
    static let ihtiWebsite = "http://theihti.org/"
}
