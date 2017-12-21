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
    
    func getUserEmail(withUID uid: String, completion: @escaping(_ email: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapShot {
                if user.key == uid {
                    completion(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func getEmail(forQuery query: String, completion: @escaping(_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        
        REF_USERS.observe(.value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapShot {
                let email = user.childSnapshot(forPath: "email").value as! String
                let username = email.components(separatedBy: "@")[0]
                
                if username.contains(query) && email != Auth.auth().currentUser?.email{
                    emailArray.append(email)
                }
            }
            completion(emailArray)
        }
    }
    
    func getUIDs(withUsernames usernames: [String], completion: @escaping (_ UIDArray: [String]) -> ()) {
        
        REF_USERS.observe(.value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else { return }
            var UIDArray = [String]()
            
            for user in userSnapShot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email) {
                    UIDArray.append(user.key)
                }
            }
            
            completion(UIDArray)
        }
    }
    
    func createGroup(withTitle title: String, andDescription description: String, forUserIds ids: [String], completion: @escaping(_ success: Bool) -> ()) {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids])
        completion(true)
    }
}








