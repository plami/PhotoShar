//
//  Post.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 11.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class Post: HasTimestamp {
    let photoURL: URL
    let userPhotoURL: URL
    let postText: String
    let timestamp: Double
    
    init?(postDictionary: [String: Any]?) {
        guard let urlString = postDictionary?["photoURL"] as? String,
            let url = URL(string: urlString),
            let userURLString = postDictionary?["userPhotoURL"] as? String,
            let userURL = URL(string: userURLString),
            let postText = postDictionary?["postText"] as? String,
            let timestamp = postDictionary?["timestamp"] as? Double else { return nil }
        self.photoURL = url
        self.postText = postText
        self.timestamp = timestamp
        self.userPhotoURL = userURL
    }
}
