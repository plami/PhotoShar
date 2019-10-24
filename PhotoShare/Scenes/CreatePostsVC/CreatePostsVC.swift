//
//  CreatePoststVC.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 10.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

class CreatePostsVC: UIViewController {

    // MARK: - Clean Swift properties
    
    @IBOutlet private weak var imageViewPost: UIImageView!
    @IBOutlet private weak var textViewPostDetails: UITextView!
    
    var interactor: CreatePostsBusinessLogic!
    var router: CreatePostsRouterLogic!
    
    private var photo: UIImage?
    
    // MARK: - Object lifecycle

    init(photo: UIImage?) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
        config()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    private func config() {
        CreatePostsConfigurator.shared.config(viewController: self)
    }
    
    private func setViews() {
        self.navigationItem.title = "Add Post"
        imageViewPost?.image = photo
        textViewPostDetails.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    @IBAction private func createPoststBtnPressed(_ sender: UIButton) {
        guard let photo = imageViewPost?.image else { return }
        sender.isEnabled = false
        PostFirebase.createPost(image: photo, postText: textViewPostDetails.text) { (status) in
            if status == true {
                sender.isEnabled = true
                self.navigationController?.popViewController(animated: true)
            } else {
                sender.isEnabled = false
            }
        }
    }
}

extension CreatePostsVC: CreatePostsDisplayLogic {
    
}

// MARK: - Clean Swift Protocols

protocol CreatePostsDisplayLogic: class {
}

