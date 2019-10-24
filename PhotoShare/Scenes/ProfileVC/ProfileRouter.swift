//
//  ProfileRouter.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation
import UIKit

class ProfileRouter: ProfileRouterLogic {

    private(set) weak var viewController: ProfileDisplayLogic?

    init(viewController: ProfileDisplayLogic) {
        
        self.viewController = viewController
    }
    
    // MARK: Routing
    func showDetailView(withPhoto: UIImage?) {
        viewController?.routeToCreatePost(withPhoto: withPhoto!)
    }
}

// MARK: - Clean Swift Protocols

protocol ProfileRouterLogic {
    func showDetailView(withPhoto: UIImage?)
}
