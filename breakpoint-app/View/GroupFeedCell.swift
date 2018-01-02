//
//  GroupFeedCell.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 02/01/2018.
//  Copyright © 2018 Brian Crowley. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var usernameLbl : UILabel!
    @IBOutlet weak var messageLbl : UILabel!
    
    func configure(username: String, message: String, image: UIImage?) {
        usernameLbl.text = username
        messageLbl.text = message
        profileImage.image = image != nil ? image : UIImage(named: "defaultProfileImage")
    }

}
