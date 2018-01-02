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
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
            completion(true)
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
    
    func getMessageFor(desiredGroup: Group, handler: @escaping(_ messagesArray: [Message]) -> ()) {
        var groupMessagesArray = [Message]()
        REF_GROUPS.child(desiredGroup.key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapShot) in
            guard let groupMessageSnapShot = groupMessageSnapShot.children.allObjects as? [DataSnapshot] else { return }
            for message in groupMessageSnapShot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(senderId: senderId, content: content)
                groupMessagesArray.append(message)
            }
            handler(groupMessagesArray)
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
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
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
    
    func getUsernames (withUID uids: [String], completion: @escaping (_ usernamesArray: [String]) -> ()) {
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else { return }
            var usernamesArray = [String]()
            
            for user in userSnapShot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if uids.contains(user.key) && user.key != Auth.auth().currentUser?.uid {
                    usernamesArray.append(email)
                }
            }
            
            completion(usernamesArray)
        }
    }
    
    func createGroup(withTitle title: String, andDescription description: String, forUserIds ids: [String], completion: @escaping(_ success: Bool) -> ()) {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids])
        completion(true)
    }
    
    func getAllGroups( completion: @escaping (_ groupsArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapShot) in
            guard let groupSnapShot = groupSnapShot.children.allObjects as? [DataSnapshot] else { return }
            for group in groupSnapShot {
                let membersArray = group.childSnapshot(forPath: "members").value as! [String]
                if membersArray.contains((Auth.auth().currentUser?.uid)!) {
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let description = group.childSnapshot(forPath: "description").value as! String
                    let group = Group(title: title, description: description, key: group.key, membersCount: membersArray.count, members: membersArray)
                    groupsArray.append(group)
                }
            }
            completion(groupsArray)
        }
    }
}








