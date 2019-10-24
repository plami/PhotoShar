//
//  SearchResultsRouter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 22.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class SearchResultsRouter: SearchResultsRouterLogic {

    private(set) weak var viewController: SearchResultsDisplayLogic?

    init(viewController: SearchResultsDisplayLogic) {
        
        self.viewController = viewController
    }
}

// MARK: - Clean Swift Protocols

protocol SearchResultsRouterLogic {}
