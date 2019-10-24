//
//  TabBarConfigurator.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 7.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class TabBarConfigurator {
    
    // MARK: - Singleton

    static var shared = TabBarConfigurator()
    
    private init() {}

    func config(viewController: TabBarViewController) {
        let presenter = TabBarPresenter(output: viewController)
        let router = TabBarRouter(viewController: viewController)
        let interactor = TabBarInteractor(output: presenter)
        viewController.interactor = interactor
        viewController.router = router
    }
}
