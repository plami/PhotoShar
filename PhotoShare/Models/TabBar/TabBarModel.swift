//
//  TabBarModel.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 7.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

enum TabBarModel {
    
    struct Response {
        
        var children: [TabBarItemType]
        var isError: Bool
        var errorMessage: String?
    }
    
    struct ViewModel {
        var type: TabBarItemType
        var tabBarItem: UITabBarItem {
            return TabBarItemFactory.create(type: type)
        }
    }
}

enum TabBarItemType: CaseIterable {

    case profile
    case friends
}
