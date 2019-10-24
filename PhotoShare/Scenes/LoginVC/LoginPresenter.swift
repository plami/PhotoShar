//
//  LoginPresenter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresentationLogic {
    
    private(set) weak var controller: LoginDisplayLogic?

    init(output: LoginDisplayLogic) {
        controller = output
    }
    
    func checkLoginCredentials(success: Bool) {
        guard let controller = controller else { return }
        guard success else { return controller.loginFailure() }
        
        return controller.loginSuccess()
    }
}

// MARK: - Clean Swift Protocols

protocol LoginPresentationLogic {
    func checkLoginCredentials(success: Bool)
}
