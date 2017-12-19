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

//COLORS
public let CLR_KEYBOARD_BUTTON_BG = #colorLiteral(red: 0.1647058824, green: 0.168627451, blue: 0.2078431373, alpha: 1)
public let CLR_KEYBOARD_BUTTON_TXT = #colorLiteral(red: 0.3176470588, green: 0.7411764706, blue: 0.3568627451, alpha: 1)
