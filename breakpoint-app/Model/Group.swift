//
//  Group.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 02/01/2018.
//  Copyright © 2018 Brian Crowley. All rights reserved.
//

import Foundation

class Group {
    
    public private(set) var title : String
    public private(set) var description : String
    public private(set) var key : String
    public private(set) var membersCount : Int
    public private(set) var members : [String]

    init(title: String, description: String, key: String, membersCount: Int, members: [String]){
        self.title = title
        self.description = description
        self.key = key
        self.membersCount = membersCount
        self.members = members
    }
}
