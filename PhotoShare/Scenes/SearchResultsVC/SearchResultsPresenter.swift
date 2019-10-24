//
//  SearchResultsPresenter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 22.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class SearchResultsPresenter: SearchResultsPresentationLogic {

    private(set) weak var controller: SearchResultsDisplayLogic?

    init(output: SearchResultsDisplayLogic) {
        
        controller = output
    }
}

// MARK: - Clean Swift Protocols

protocol SearchResultsPresentationLogic { }
