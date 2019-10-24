//
//  PostsConfigurator.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 11.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class PostsConfigurator {

    // MARK: - Singleton

    static var shared = PostsConfigurator()
    
    private init() {}

    func config(viewController: PostsVC) {
        let presenter = PostsPresenter(output: viewController)
        let router = PostsRouter(viewController: viewController)
        let interactor = PostsInteractor(output: presenter)
        viewController.interactor = interactor
        viewController.router = router
    }
}
