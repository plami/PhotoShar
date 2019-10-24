//
//  TabBarItemFactory.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 7.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

class TabBarItemFactory {
    static func create(type: TabBarItemType) -> UITabBarItem {
        switch type {
        case .profile:
            return UITabBarItem(title: "",
                                image: #imageLiteral(resourceName: "profile").withRenderingMode(.automatic),
                                selectedImage: #imageLiteral(resourceName: "profile").withRenderingMode(.alwaysOriginal))
        case .friends:
            return UITabBarItem(title: "",
                                image: #imageLiteral(resourceName: "friends").withRenderingMode(.automatic),
                                selectedImage: #imageLiteral(resourceName: "friends").withRenderingMode(.alwaysOriginal))
        }
    }
}
