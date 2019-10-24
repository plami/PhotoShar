//
//  TabBarInteractor.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 7.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class TabBarInteractor: TabBarBusinessLogic {
    
    let presenter: TabBarPresentationLogic!

    init(output: TabBarPresentationLogic) {
        
        presenter = output
    }
}

extension TabBarInteractor {

    func requestChildren() {
        let response = TabBarModel.Response(children: TabBarItemType.allCases,
                                            isError: false,
                                            errorMessage: nil)
        presenter.presentChildren(response)
    }
}

// MARK: - Clean Swift Protocols

protocol TabBarBusinessLogic {

    func requestChildren()
}
