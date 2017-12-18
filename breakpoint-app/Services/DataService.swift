//
//  DataService.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 15/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let instance = DataService()
    
    func createDataBaseUser( uniqueID: String, userData: Dictionary<String, Any> ) {
        REF_USERS.child(uniqueID).updateChildValues(userData)
    }
    
    func uploadPost (withMessage message: String, forUID uid: String, andGroupKey groupKey: String?, completion: @escaping CompletionHandler ) {
        if groupKey != nil {
            // do something
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            completion(true)
        }
    }
}
