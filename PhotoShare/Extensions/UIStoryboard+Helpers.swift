//
//  UIStoryboard+Helpers.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 7.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

struct Storyboard {
    
    static let main = "Main"
}

extension UIStoryboard {
    
    class var main: UIStoryboard {
        return UIStoryboard(name: Storyboard.main, bundle: nil)
    }
    
    func controllerWithID(_ id: StoryboardID) -> UIViewController {
        return self.instantiateViewController(withIdentifier: id.rawValue)
    }
}

enum StoryboardID: String {
    
    case tabBarViewController
    
    var name: String {
        return self.rawValue
    }
}
