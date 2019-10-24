//
//  CreatePostsInteractor.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 10.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class CreatePostsInteractor: CreatePostsBusinessLogic {

    var presenter: CreatePostsPresentationLogic!
    var photo: String?
    
    init(output: CreatePostsPresentationLogic) {
        
        presenter = output
    }
}

// MARK: - Clean Swift Protocols

protocol CreatePostsBusinessLogic {

}

protocol CreatePostsDataStore
{
  var photo: String? { get set }
}

