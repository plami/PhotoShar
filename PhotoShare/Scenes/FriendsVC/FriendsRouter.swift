//
//  FriendsRouter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class FriendsRouter: FriendsRouterLogic {

    private(set) weak var viewController: FriendsDisplayLogic?

    init(viewController: FriendsDisplayLogic) {
        
        self.viewController = viewController
    }
}

// MARK: - Clean Swift Protocols

protocol FriendsRouterLogic {}
