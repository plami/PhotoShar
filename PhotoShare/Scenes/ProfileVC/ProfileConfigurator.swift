//
//  ProfileConfigurator.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class ProfileConfigurator {

    // MARK: - Singleton

    static var shared = ProfileConfigurator()
    
    private init() {}

    func config(viewController: ProfileVC) {
        let presenter = ProfilePresenter(output: viewController)
        let router = ProfileRouter(viewController: viewController)
        let interactor = ProfileInteractor(output: presenter)
        viewController.interactor = interactor
        viewController.router = router
    }
}
