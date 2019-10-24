//
//  PostsPresenter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 11.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class PostsPresenter: PostsPresentationLogic {

    private(set) weak var controller: PostsDisplayLogic?

    init(output: PostsDisplayLogic) {
        
        controller = output
    }
}

// MARK: - Clean Swift Protocols

protocol PostsPresentationLogic { }
