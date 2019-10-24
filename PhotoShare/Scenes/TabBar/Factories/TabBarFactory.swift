//
//  TabBarFactory.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 7.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

class TabBarFactory {
    static func childViewControllerForModel(_ model: TabBarModel.ViewModel) -> UIViewController {
        
        let viewController: UIViewController?
        switch model.type {
        case .profile:
            viewController = ProfileVC(sectionType: .profile)
        case .friends:
            viewController = FriendsVC(sectionType: .friends)
        }
        
        viewController?.tabBarItem = model.tabBarItem
        guard let vc = viewController else {
            fatalError("No View Controller!!!")
        }
        return vc
    }
}
