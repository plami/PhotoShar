//
//  UITableView+Helpers.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell >(_ cellType: T.Type) {
        let name = String(describing: cellType)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellReuseIdentifier: name)
    }
    
    func registerCells<T: UITableViewCell>(_ cellTypes: [T.Type]) {
        for cellType in cellTypes {
            let name = String(describing: cellType)
            let nib = UINib(nibName: name, bundle: nil)
            self.register(nib, forCellReuseIdentifier: name)
        }
    }
    
    func dequeueCell<T: UITableViewCell>(_ cellType: T.Type) -> T {
        let name = String(describing: cellType)
        guard let cell = dequeueReusableCell(withIdentifier: name) as? T else {
            fatalError("Could not dequeue cell with identifier: \(name)")
        }
        return cell
    }
    
    func dequeueHeader<T: UITableViewHeaderFooterView>(_ headerType: T.Type) -> T {
        let name = String(describing: headerType)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: name) as? T else {
            fatalError("Could not dequeue cell with identifier: \(name)")
        }
        return cell
    }
    
    // Default delay time = 0.5 seconds
    // Pass delay time interval, as a parameter argument
    func reloadDataAfterDelay(delayTime: TimeInterval) {
        self.perform(#selector(self.reloadData), with: nil, afterDelay: delayTime)
    }
}
