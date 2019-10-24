//
//  SearchResultsInteractor.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 22.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class SearchResultsInteractor: SearchResultsBusinessLogic {

    var presenter: SearchResultsPresentationLogic!
    
    init(output: SearchResultsPresentationLogic) {
        
        presenter = output
    }
}

// MARK: - Clean Swift Protocols

protocol SearchResultsBusinessLogic {

}
