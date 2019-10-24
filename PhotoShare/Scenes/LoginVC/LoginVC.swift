//
//  LoginVC.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 3.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth

class LoginVC: UIViewController {

    // MARK: - Clean Swift properties
    
    var interactor: LoginBusinessLogic!
    var router: LoginRouterLogic!
    
    // MARK: - Object lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Setup
    
    func configure() {
        LoginConfigurator.shared.config(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLoginCredentials()
    }
    
    private func setUpLoginCredentials() {
        let loginButton: FBLoginButton = FBLoginButton()
        loginButton.permissions = ["public_profile", "email"]
        loginButton.center = view.center
        view.addSubview(loginButton)
        loginButton.delegate = self
    }
}

extension LoginVC: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        interactor.loginUser(result: result)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
}

extension LoginVC: LoginDisplayLogic {
    
    func loginSuccess() {
        guard let tabBarViewController = TabBarViewController.storyboardInstance() else { return }
        self.show(tabBarViewController, sender: nil)

    }
    
    func loginFailure() {
        self.showAlert(withTitle: "", message: "Incorrect login!", buttonTitle: "OK", preferredStyle: .alert, completion: nil)
    }
}


// MARK: - Clean Swift Protocols

protocol LoginDisplayLogic: class {
    
    func loginSuccess()
    func loginFailure()
}
