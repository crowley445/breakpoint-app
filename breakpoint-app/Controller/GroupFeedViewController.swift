//
//  GroupFeedViewController.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 02/01/2018.
//  Copyright © 2018 Brian Crowley. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedViewController: UIViewController {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var sendMessageField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    @IBAction func didPressBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressSendButton(_ sender: Any) {
        if sendMessageField.text == "" { return }
        sendMessageField.isEnabled = false
        sendButton.isEnabled = false
        DataService.instance.uploadPost(withMessage: sendMessageField.text!, forUID: (Auth.auth().currentUser?.uid)!, andGroupKey: group?.key) { (complete) in
            if complete {
                self.sendMessageField.text = ""
                self.sendMessageField.isEnabled = true
                self.sendButton.isEnabled = true
            }
        }
    }
    
    var group: Group?
    var groupMessages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        sendView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.title
        DataService.instance.getUsernames(withUID: (group?.members)!) { (usernameArray) in
            self.membersLbl.text = usernameArray.joined(separator: ", ")
        }
        
        REF_GROUPS.observe(.value) { (snapShot) in
            DataService.instance.getMessageFor(desiredGroup: self.group!, handler: { (returnedMessages) in
                self.groupMessages = returnedMessages
                self.tableView.reloadData()
                if self.groupMessages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath.init(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }
    
    func initWithData( group: Group) {
        self.group = group
    }
}

extension GroupFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        let message = groupMessages[indexPath.row]
        DataService.instance.getUserEmail(withUID: message.senderId) { (userEmail) in
            cell.configure(username: userEmail, message: message.content, image: nil)
        }
        return cell
    }
}




