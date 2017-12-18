//
//  AuthService.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 18/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    static let instance = AuthService()
    typealias CompletionHandler = (_ status: Bool, _ error: Error?) -> ()
    
    func registerUser(withEmail email: String, andPassword password: String, completion: @escaping CompletionHandler) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else { completion(false, error); return}
            
            DataService.instance.createDataBaseUser(uniqueID: user.uid, userData: ["provider" : user.providerID, "email": user.email as Any])
            completion(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, completion: @escaping CompletionHandler) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil { completion(false, error); return }
            completion(true, nil)
        }
    }
    
}
