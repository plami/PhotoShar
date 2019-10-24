//
//  TabBarRouter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 7.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class TabBarRouter: TabBarRouterLogic {
    
    private(set) weak var viewController: TabBarDisplayLogic?
    
    init(viewController: TabBarDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: - Clean Swift Protocols

protocol TabBarRouterLogic { }
