//
//  NewGroupViewController.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 21/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit
import Firebase

class NewGroupViewController: UIViewController {

    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var groupMembersTextField: InsetTextField!
    @IBOutlet weak var choosenMembersLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    var emailArray = [String]()
    var choosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        groupMembersTextField.delegate = self
        groupMembersTextField.addTarget(self, action: #selector(groupMembersTextFieldDidChange), for: .editingChanged)
    }
    
    @objc func groupMembersTextFieldDidChange() {
        if groupMembersTextField.text == "" {
            emailArray.removeAll()
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forQuery: groupMembersTextField.text!, completion: { (returnEmailArray) in
                self.emailArray = returnEmailArray
                self.tableView.reloadData()
            })
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if titleTextField.text == "" || groupMembersTextField.text == "" { return }
        DataService.instance.getUIDs(withUsernames: choosenUserArray) { (returnedIDsArray) in
            var userIds = returnedIDsArray
            userIds.append((Auth.auth().currentUser?.uid)!)
            DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: userIds, completion: { (success) in
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
}

extension NewGroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as? MemberCell else { return UITableViewCell()}
        
        cell.configureCell(withImage: nil , andEmail: emailArray[indexPath.row], setSelected: choosenUserArray.contains(emailArray[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MemberCell else { return }
        let email = cell.userEmailLabel.text!
        
        if !choosenUserArray.contains(email) {
            choosenUserArray.append(email)
        } else {
            choosenUserArray = choosenUserArray.filter({$0 != cell.userEmailLabel.text})
        }
        
        cell.checkmarkImageView.isHidden = !choosenUserArray.contains(cell.userEmailLabel.text!)
        choosenMembersLabel.text = choosenUserArray.count > 0 ? choosenUserArray.joined(separator: ", ") : "add people to your group"
        doneButton.isHidden = choosenUserArray.count < 1
    }
}

extension NewGroupViewController: UITextFieldDelegate {

}







