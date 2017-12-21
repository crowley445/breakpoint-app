//
//  MemberCell.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 21/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell {

    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    func configureCell(withImage image: UIImage?, andEmail email: String, setSelected selected: Bool) {
        userEmailLabel.text = email
        userImageView.image = image != nil ? image : UIImage(named: "defaultProfileImage")
        checkmarkImageView.isHidden = !selected
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
