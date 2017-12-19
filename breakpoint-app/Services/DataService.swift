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
    
    func getAllFeedMessages( handler: @escaping (_ messages: [Message]) -> () ) {
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            var messageArray = [Message]()
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(senderId: senderId, content: content)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
}
