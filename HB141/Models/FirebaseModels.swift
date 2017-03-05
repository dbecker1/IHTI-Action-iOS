//
//  FirebaseModels.swift
//  HB141
//
//  Created by Daniel Becker on 2/22/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import Foundation
import Firebase

class User : FIRDataObject {
    var reputation : Int?
}

class Report : FIRDataObject {
    public var Comment : String = ""
    public var Datetime : String = ""
    public var EID : String = ""
    public var NoView: String = ""
    public var PublicView: String = ""
    public var RestroomView: String = ""
    public var VID: String = ""
    
    override func toDictionary() -> Dictionary<String, Any> {
        return self.dictionaryWithValues(forKeys: ["Comment", "Datetime", "EID", "NoView", "PublicView", "RestroomView", "VID"])
    }
}

class Establishment : FIRDataObject {
    public var Address : String?
    public var Name : String?
    public var PhoneNumber : String?
}


class FIRDataObject: NSObject {
    
//    var snapshot: FIRDataSnapshot?
//    var key: String { return snapshot!.key }
//    var ref: FIRDatabaseReference { return snapshot!.ref }
    
    required init(snapshot: FIRDataSnapshot) {
        
        //self.snapshot = snapshot
        
        super.init()
        
        for child in snapshot.children.allObjects as? [FIRDataSnapshot] ?? [] {
            let key = String(child.key.characters.filter { !" \n\t\r".characters.contains($0) })
            print(key)
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
