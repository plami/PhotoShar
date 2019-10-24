//
//  ProfileInteractor.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation
import FirebaseAuth

class ProfileInteractor: ProfileBusinessLogic {

    var presenter: ProfilePresentationLogic!
    
    init(output: ProfilePresentationLogic) {
        
        presenter = output
    }
    
    func getUserCredentials() {
        if let user = Auth.auth().currentUser {
          for profile in user.providerData {
            guard
                let photoUrl = profile.photoURL,
                let name = profile.displayName,
                let email = profile.email
            else { return }
            presenter.getUserCredentials(photoUrl: photoUrl, name: name, email: email)
          }
        } else {
          // No user is signed in.
        }
    }
}

// MARK: - Clean Swift Protocols

protocol ProfileBusinessLogic {
    func getUserCredentials()
}
