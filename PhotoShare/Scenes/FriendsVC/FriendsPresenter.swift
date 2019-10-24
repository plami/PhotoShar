//
//  FriendsPresenter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class FriendsPresenter: FriendsPresentationLogic {

    private(set) weak var controller: FriendsDisplayLogic?

    init(output: FriendsDisplayLogic) {
        
        controller = output
    }
}

// MARK: - Clean Swift Protocols

protocol FriendsPresentationLogic {
}
