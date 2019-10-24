//
//  LoginRouter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class LoginRouter: LoginRouterLogic {

    private(set) weak var viewController: LoginDisplayLogic?

    init(viewController: LoginDisplayLogic) {
        self.viewController =  viewController
    }
    
}

// MARK: - Clean Swift Protocols

protocol LoginRouterLogic { }
