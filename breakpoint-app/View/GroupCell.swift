//
//  GroupCell.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 02/01/2018.
//  Copyright © 2018 Brian Crowley. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    
    func configureCell(withTitle title: String, Description description: String, andMembersCount count: Int) {
        titleLbl.text = title
        descriptionLbl.text = description
        membersLbl.text = "\(count) members."
    }
}
