//
//  PostsCollectionViewCell.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 11.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

class PostsCollectionViewCell: UICollectionViewCell, Identifiable, ReusableView {

    @IBOutlet weak var imageViewPosts: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(withPhoto: URL) {
        let data = try? Data(contentsOf: withPhoto)

        if let imageData = data {
            let image = UIImage(data: imageData)
            imageViewPosts?.image = image
        }
    }
}
