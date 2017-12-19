//
//  Message.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 19/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import Foundation

class Message {
    
    public private(set) var senderId: String
    public private(set) var content: String

    init(senderId: String, content: String) {
        self.senderId = senderId
        self.content = content
    }
}
