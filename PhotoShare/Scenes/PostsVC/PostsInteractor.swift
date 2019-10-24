//
//  PostsInteractor.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 11.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class PostsInteractor: PostsBusinessLogic {

    var presenter: PostsPresentationLogic!
    
    init(output: PostsPresentationLogic) {
        
        presenter = output
    }
}

// MARK: - Clean Swift Protocols

protocol PostsBusinessLogic {

}
