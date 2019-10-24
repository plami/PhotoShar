//
//  LoginConfigurator.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class LoginConfigurator {

    // MARK: - Singleton

    static var shared = LoginConfigurator()
    private init() { }

    func config(viewController: LoginVC) {
        let presenter = LoginPresenter(output: viewController)
        let router = LoginRouter(viewController: viewController)
        let interactor = LoginInteractor(output: presenter)
        viewController.interactor = interactor
        viewController.router = router
    }
}
