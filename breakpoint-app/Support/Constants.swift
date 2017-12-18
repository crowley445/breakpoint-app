//
//  Constants.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 15/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import Foundation
import Firebase

typealias CompletionHandler = (_ success: Bool) -> Void

public let DB_BASE = Database.database().reference()
public let REF_USERS = DB_BASE.child("users")
public let REF_GROUPS = DB_BASE.child("groups")
public let REF_FEED = DB_BASE.child("feed")

//STORYBOARD ID

public let ID_SB_AUTHVC = "AuthViewController"
public let ID_SB_LOGINVC = "LoginViewController"
