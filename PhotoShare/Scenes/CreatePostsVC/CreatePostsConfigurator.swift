//
//  CreatePostsConfigurator.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 10.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class CreatePostsConfigurator {

    // MARK: - Singleton

    static var shared = CreatePostsConfigurator()
    
    private init() {}

    func config(viewController: CreatePostsVC) {
        let presenter = CreatePostsPresenter(output: viewController)
        let router = CreatePostsRouter(viewController: viewController)
        let interactor = CreatePostsInteractor(output: presenter)
        viewController.interactor = interactor
        viewController.router = router
    }
}
