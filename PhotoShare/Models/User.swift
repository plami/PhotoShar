//
//  User.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 14.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class PFUser {
    let name: String
    let photoURL: URL
    let userID: String
    var isFriend = false
    var isInvited = false
    
    init?(userDictionary: [String: Any]?) {
        guard let name = userDictionary?["name"] as? String,
            let photoURL = userDictionary?["photoURL"] as? String,
            let url = URL(string: photoURL),
            let userID = userDictionary?["userID"] as? String else {
            return nil }
        
        self.name = name
        self.photoURL = url
        self.userID = userID
    }
}
