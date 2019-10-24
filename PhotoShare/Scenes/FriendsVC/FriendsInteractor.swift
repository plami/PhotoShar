//
//  FriendsInteractor.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class FriendsInteractor: FriendsBusinessLogic {

    var presenter: FriendsPresentationLogic!
    
    init(output: FriendsPresentationLogic) {
        
        presenter = output
    }
}

// MARK: - Clean Swift Protocols

protocol FriendsBusinessLogic {

}

protocol FriendsDataStore {
    // create a dataStore here for events
}
