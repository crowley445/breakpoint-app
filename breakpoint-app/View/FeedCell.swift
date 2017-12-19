//
//  FeedCell.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 19/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    
    func configureCell(withImage image: UIImage, withEmail email: String, andMessage message: String) {
        self.userImageView.image = image
        self.emailLbl.text = email
        self.messageLbl.text = message
    }
}
