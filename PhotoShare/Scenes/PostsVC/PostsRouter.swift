//
//  PostsRouter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 11.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class PostsRouter: PostsRouterLogic {

    private(set) weak var viewController: PostsDisplayLogic?

    init(viewController: PostsDisplayLogic) {
        
        self.viewController = viewController
    }
}

// MARK: - Clean Swift Protocols

protocol PostsRouterLogic {}
