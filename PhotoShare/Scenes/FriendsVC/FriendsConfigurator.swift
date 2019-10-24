//
//  FriendsConfigurator.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class FriendsConfigurator {

    // MARK: - Singleton

    static var shared = FriendsConfigurator()
    
    private init() {}

    func config(viewController: FriendsVC) {
        let presenter = FriendsPresenter(output: viewController)
        let router = FriendsRouter(viewController: viewController)
        let interactor = FriendsInteractor(output: presenter)
        viewController.interactor = interactor
        viewController.router = router
    }
}
