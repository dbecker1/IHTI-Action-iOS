//
//  UserService.swift
//  HB141
//
//  Created by Daniel Becker on 6/14/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import Foundation
import FacebookCore
import FirebaseDatabase

class UserService {
    static func updateEmailFromFB() {
        let current = AuthManager.shared.current()
        let params = ["fields" : "email"]
        let graphRequest = GraphRequest(graphPath: "me", parameters: params)
        graphRequest.start {
            (urlResponse, requestResult) in
            
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
                break
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    let email = responseDictionary["email"] as? String
                    
                    //TODO: Add check to see if previous user exists with this email, and then merge
                    current?.updateEmail(email!, completion: nil)
                }
            }
        }
    }
    
    static func createUserIfNecessary(result: ((User) -> Void)!) {
        let current = AuthManager.shared.current()
        if current?.email != nil {
            getUser(by: current!.email!) {
                (user) in
                if user == nil {
                    let service = FirebaseService(table: .users)
                    let newUser = User()
                    newUser.Email = current!.email!
                    newUser.Name = current!.displayName!
                    newUser.IsActive = "true"
                    let key = service.getKey()
                    service.enterData(forIdentifier: key, data: newUser)
                    result(newUser)
                } else {
                    result(user!)
                }
                // TODO: ADD UPDATE ABILITIES
            }
        }
    }
    
    static func getUser(by email: String, result: ((User?) -> Void)!) {
        let ref = FIRDatabase.database().reference()
        let userRef = ref.child(FirebaseTable.users.rawValue)
        let query = userRef.queryEqual(toValue: email, childKey: "email")
        query.observeSingleEvent(of: .value, with: {
            (snapshot) in
            let service = FirebaseService(table: .users)
            if (!snapshot.exists()) {
                result(nil)
            } else {
                let user = service.convertSnapshot(snapshot: snapshot) as! User
                result(user)
            }
        })
    }
}
