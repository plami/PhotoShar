//
//  CreatePostsPresenter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 10.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class CreatePostsPresenter: CreatePostsPresentationLogic {

    private(set) weak var controller: CreatePostsDisplayLogic?

    init(output: CreatePostsDisplayLogic) {
        
        controller = output
    }
}

// MARK: - Clean Swift Protocols

protocol CreatePostsPresentationLogic {}
