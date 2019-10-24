//
//  UIViewController+Extended.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 4.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit
import FBSDKLoginKit

extension UIViewController {
    
    // MARK: - Bar Buttons
    
    var logoutButton: UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setTitle("LogOut", for: .normal)
        button.tintColor = .white
        button.addTarget(self,
                         action: #selector(logoutBtnPressed(_:)),
                         for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    @objc
    private func logoutBtnPressed(_ sender: Any) {
        let manager = LoginManager()
        manager.logOut()
        UserFirebase.signout()
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(
        withTitle title: String = "",
        message: String = "",
        buttonTitle: String = "",
        preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil ) {
        
        let alerController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
            alerController.dismiss(animated: true, completion: nil)
        }
        alerController.addAction(okAction)
        
        self.present(alerController, animated: true, completion: nil)
    }
}
