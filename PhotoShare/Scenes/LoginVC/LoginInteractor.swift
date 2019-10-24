//
//  LoginInteractor.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FirebaseAuth

class LoginInteractor: LoginBusinessLogic {

    let presenter: LoginPresentationLogic!
    private let worker = UserFirebase()

    init(output: LoginPresentationLogic) {
        presenter = output
    }
    
    func loginUser(result: LoginManagerLoginResult?) {
        UserFirebase.signIn(result: result!) { (status) in
            guard status == false else { self.presenter.checkLoginCredentials(success: true)
                return
            }
            self.presenter.checkLoginCredentials(success: false)
        }
    }
}

// MARK: - Clean Swift Protocols

protocol LoginBusinessLogic {
    func loginUser(result: LoginManagerLoginResult?)
}
