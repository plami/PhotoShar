//
//  ProfilePResenter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfilePresentationLogic {

    private(set) weak var controller: ProfileDisplayLogic?

    init(output: ProfileDisplayLogic) {
        
        controller = output
    }
    
    func getUserCredentials(photoUrl: URL, name: String, email: String) {
        controller?.getUserCredentials(photoUrl: photoUrl, name: name, email: email)
    }
}

// MARK: - Clean Swift Protocols

protocol ProfilePresentationLogic {
    func getUserCredentials(photoUrl: URL, name: String, email: String)
}
