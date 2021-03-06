//
//  AuthManager.swift
//  HB141
//
//  Created by Daniel Becker on 4/7/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn
import FacebookCore
import FacebookLogin

class AuthManager {
    static let shared = AuthManager()
    
    var user : User = User()
    
    func current() -> FIRUser? {
        return FIRAuth.auth()?.currentUser
    }
    
    func loginStandard(username: String, password: String, completion : ((_ isSuccessful: Bool) -> Void)!) {
        FIRAuth.auth()?.signIn(withEmail: username, password: password) {
            (user, error) in
            if completion != nil {
                if error != nil {
                    completion(false)
                } else {
                    completion(true)
                    self.loadUser()
                }
            }
        }
    }
    
    func loginGoogle(user: GIDGoogleUser!, completion: ((_ isSuccessful: Bool) -> Void)!) {
        guard let authentication = user.authentication else {
            return
        }
        
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        loginExternal(credential: credential, completion: completion)
    }
    
    func loginFacebook(loginResult: LoginResult, completion: ((_ isSuccessful: Bool) -> Void)!) {
        switch loginResult {
        case .failed(_):
            completion(false)
        case .success(_, _, let accessToken):
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
            self.loginExternal(credential: credential) {
                (isSuccessful) -> Void in
                completion(isSuccessful)
                if isSuccessful {
                    let current = self.current()
                    if (current?.email == nil) { // new user. get email from Facebook
                        UserService.updateEmailFromFB()
                    }
                }
            }
        default:
            print("Facebook Login Result neither Success or Failure")
        }

    }
    
    func createUserStandard(emailAddress: String, password: String, name: String, completion: ((_ isSuccessful: Bool) -> Void)!) {
        FIRAuth.auth()?.createUser(withEmail: emailAddress, password: password) {
            (user, error) -> Void in
            if completion != nil {
                if error != nil {
                    completion(false)
                } else {
                    let change = FIRAuth.auth()?.currentUser?.profileChangeRequest()
                    change?.displayName = name
                    change?.commitChanges() {
                        (error) -> Void in
                        if error != nil {
                            completion(false)
                        } else {
                            completion(true)
                            self.createUser()
                        }
                    }
                }
            }
        }
    }
    
    func updateEmail(emailAddress: String, completion: ((_ isSuccessful: Bool) -> Void)!) {
        FIRAuth.auth()?.currentUser?.updateEmail(emailAddress) {
            (error) -> Void in
            if completion != nil {
                if error != nil {
                    completion(false)
                } else {
                    completion(true)
                    //self.loadUser() UPDATE USER
                }
            }
        }
    }
    
    func updatePassword(password: String, completion: ((_ isSuccessful: Bool) -> Void)!) {
        FIRAuth.auth()?.currentUser?.updatePassword(password) {
            (error) -> Void in
            if completion != nil {
                if error != nil {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
    
    func updateName(name: String, completion: ((_ isSuccessful: Bool) -> Void)!) {
        let change = FIRAuth.auth()?.currentUser?.profileChangeRequest()
        change?.displayName = name
        change?.commitChanges(){
            (error) -> Void in
            if completion != nil {
                if error != nil {
                    completion(false)
                } else {
                    completion(true)
                    //self.loadUser() UPDATE USER
                }
            }
        }
    }
    
    func logOut(completion: ((_ isSuccessful: Bool) -> Void)!) {
        do {
            if AccessToken.current != nil { // authenticated with Facebook
                let loginManager = LoginManager()
                loginManager.logOut()
            }
            if GIDSignIn.sharedInstance().hasAuthInKeychain() {
                GIDSignIn.sharedInstance().signOut()
            }
            try FIRAuth.auth()?.signOut()
            completion(true)
        } catch let error as NSError {
            print("Error signing out: \(error)")
            completion(false)
        }
    }
    
    func userHasStandard() -> Bool {
        return userHasLoginType(type: "password")
    }
    
    func userHasFacebook() -> Bool {
        return userHasLoginType(type: "facebook")
    }
    
    func userHasGoogle() -> Bool {
        return userHasLoginType(type: "google")
    }
    
    private func userHasLoginType(type: String) -> Bool {
        let user = current()
        for provider in (user?.providerData)! {
            if provider.providerID.contains(type) {
                return true;
            }
        }
        return false
    }
    
    private func loginExternal(credential: FIRAuthCredential, completion: ((_ isSuccessful : Bool) -> Void)!) {
        FIRAuth.auth()?.signIn(with: credential) {
            (user, error) in
            if completion != nil {
                if error != nil {
                    completion(false)
                } else {
                    self.loadUser()
                    completion(true)
                }
            }
        }
    }
    
    private func createUser() {
        UserService.createUser() {
            (user) in
            self.user = user
        }
    }
    
    private func loadUser() {
        UserService.getUser(by: (current()?.email)!) {
            (user) in
            self.user = user!
        }
    }
}
