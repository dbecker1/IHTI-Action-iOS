//
//  FirebaseService.swift
//  HB141
//
//  Created by Daniel Becker on 2/22/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//
import Firebase

class FirebaseService : NSObject {
    var ref: FIRDatabaseReference!
    var table: FirebaseTable?
    
    override init() {
        super.init()
        
        ref = FIRDatabase.database().reference()
    }
    
    init(table: FirebaseTable) {
        super.init()
        ref = FIRDatabase.database().reference()
        self.table = table
    }
    
    func enterData(forIdentifier identifier: String, data: FIRDataObject) {
        if let table = table {
            self.ref.child(table.rawValue).child(identifier).setValue(data.toDictionary())
        } else {
            print("Unable to enter data. Desired table not set.")
        }
    }
    
    func retrieveData(forIdentifier identifier: String, callback: @escaping ((FIRDataObject) -> Void)) {
        if let table = table {
            ref.child(table.rawValue).child(identifier).observeSingleEvent(of: .value, with: { (snapshot) in
                let data = self.convertSnapshot(snapshot: snapshot)
                callback(data)
            }) { (error) in
                print(error.localizedDescription)
            }
        } else {
            print("Unable to retrieve data. Desired table not set")
        }
        
    }
    
    func getKey() -> String {
        let key = ref.child((table?.rawValue)!).childByAutoId().key
        
        return key
    }
    
    private func convertSnapshot(snapshot: FIRDataSnapshot) -> FIRDataObject {
        switch table! {
        case FirebaseTable.users :
            let user = User(snapshot: snapshot)
            return user
        case FirebaseTable.report :
            let report = Report(snapshot: snapshot)
            return report
        case FirebaseTable.establishment :
            let establishment = Establishment(snapshot: snapshot)
            return establishment
        }
    }
    
}

enum FirebaseTable : String {
    case users = "users"
    case report = "report"
    case establishment = "establishment"
}
