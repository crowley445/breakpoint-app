//
//  FirstViewController.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 15/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.getAllFeedMessages { (returnedMessages) in
            self.messageArray = returnedMessages
            print("MESSAGES: \(self.messageArray.count)")
            self.tableView.reloadData()
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedCell else { return UITableViewCell()}
        let defaultImage = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        cell.configureCell(withImage: defaultImage!, withEmail: message.senderId, andMessage: message.content)
        return cell
    }
}

