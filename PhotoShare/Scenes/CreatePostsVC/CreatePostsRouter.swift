//
//  CreatePostsRouter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 10.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class CreatePostsRouter: CreatePostsRouterLogic {
    
    private(set) weak var viewController: CreatePostsDisplayLogic?
    
    init(viewController: CreatePostsDisplayLogic) {
        self.viewController =  viewController
    }
}

// MARK: - Clean Swift Protocols

protocol CreatePostsRouterLogic {}
