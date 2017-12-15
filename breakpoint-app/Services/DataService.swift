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
    
    func createDataBaseUser( uniqueID: String, userData: Dictionary<String, Any> ) {
        REF_USERS.child(uniqueID).updateChildValues(userData)
    }
}
