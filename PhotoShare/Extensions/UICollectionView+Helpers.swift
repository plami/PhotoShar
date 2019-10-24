//
//  UICollectionView+Helpers.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 15.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation
import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String { return String(describing: Self.self) }
}

protocol NibNameRepresentable {
    static var nibName: String { get }
}

extension NibNameRepresentable {
    static var nibName: String { return String(describing: Self.self) }
    static var nib: UINib { return UINib(nibName: Self.nibName, bundle: nil) }
}


protocol ReusableView: Identifiable, NibNameRepresentable {}

extension UICollectionView {
    // In case you have a cell called `SmallClipTableCell` you can use this method as
    // tableView.registerCell(SmallClipTableCell)
    func registerCellNib<T>(_ cellType: T.Type) where T: ReusableView, T: UICollectionViewCell {
        self.register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    // In case you have a cell called `SmallClipTableCell` you can use this method as
    // tableView.registerCell(SmallClipTableCell)
    func registerCellClass<T>(_ cellType: T.Type) where T: Identifiable, T: UICollectionViewCell {
        self.register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    // In case you have a cell called `SmallClipTableCell` you can use this method as
    // let cell: SmallClipTableCell = tableView.dequeueCell()
    func dequeueCell<T>(at indexPath: IndexPath) -> T where T: UICollectionViewCell, T: ReusableView {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else { fatalError("No \(T.identifier) available") }
        return cell
    }
}
extension UIView {
    
    class func fromNib<T>() -> T where T: UIView, T: NibNameRepresentable {
        guard let view = Bundle.main.loadNibNamed(T.nibName, owner: self, options: nil)?.first as? T else { fatalError("No \(T.nibName) available") }
        return view
    }
}
