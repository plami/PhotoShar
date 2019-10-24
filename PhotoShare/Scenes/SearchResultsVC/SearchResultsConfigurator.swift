//
//  SearchResultsConfigurator.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 22.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class SearchResultsConfigurator {

    // MARK: - Singleton

    static var shared = SearchResultsConfigurator()
    
    private init() {}

    func config(viewController: SearchResultsVC) {
        let presenter = SearchResultsPresenter(output: viewController)
        let router = SearchResultsRouter(viewController: viewController)
        let interactor = SearchResultsInteractor(output: presenter)
        viewController.interactor = interactor
        viewController.router = router
    }
}

