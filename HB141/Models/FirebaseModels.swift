//
//  FirebaseModels.swift
//  HB141
//
//  Created by Daniel Becker on 2/22/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class User : FIRDataObject {
    public var Name : String = ""
    public var Email : String = ""
    public var IsActive : String = ""
    
    override func toDictionary() -> Dictionary<String, Any> {
        return self.dictionaryWithValues(forKeys: ["Name", "Email", "IsActive"])
    }
}

class Report : FIRDataObject {
    public var Comment : String = ""
    public var Datetime : String = ""
    public var EID : String = ""
    public var NoView: String = ""
    public var PublicView: String = ""
    public var RestroomView: String = ""
    public var VID: String = ""
    
    public var establishment: Establishment? = nil
    
    override func toDictionary() -> Dictionary<String, Any> {
        return ["Comment" : Comment, "Datetime" : Datetime, "EID" : EID, "No View" : NoView, "Public View" : PublicView, "Restroom View" : RestroomView, "VID" : VID]
    }
}

class Establishment : FIRDataObject {
    public var Address : String = ""
    public var Name : String = ""
    public var PhoneNumber : String = ""
    public var Website : String = ""
    
    override func toDictionary() -> Dictionary<String, Any> {
        return self.dictionaryWithValues(forKeys: ["Address", "Name", "PhoneNumber", "Website"])
    }
}


class FIRDataObject: NSObject {
    
    required init(snapshot: FIRDataSnapshot) {
        
        super.init()
        
        for child in snapshot.children.allObjects as? [FIRDataSnapshot] ?? [] {
            let key = String(child.key.characters.filter { !" \n\t\r".characters.contains($0) })
            if responds(to: Selector(key)) {
                if child.value is Bool {
                    let boolValue = child.value as! Bool
                    let boolString = boolValue.description
                    setValue(boolString, forKey: key)
                } else {
                    setValue(child.value, forKey: key)
                }
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        return Dictionary<String, Any>()
    }
}

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
