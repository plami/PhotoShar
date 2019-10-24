//
//  FriendsTableViewCell.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(name: String) {
        self.selectionStyle = .none
        self.textLabel?.text = name
    }
}
