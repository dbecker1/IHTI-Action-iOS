//
//  Business.swift
//  HB141
//
//  Created by Daniel Becker on 2/9/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import Foundation
import UIKit

class Business : NSObject {
    var businessName : String?
    var businessType : String?
    var businessAddress : String?
    var placeID : String?
    // I know this violates the idea of separating model from view, but it simplifies things - Daniel
    var image : UIImage?
}
