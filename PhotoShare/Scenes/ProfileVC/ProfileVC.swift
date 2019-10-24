//
//  ProfileVC.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 3.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDWebImage

class ProfileVC: UIViewController {

    // MARK: - Clean Swift properties
    
    @IBOutlet private weak var imageViewProfile: UIImageView?
    @IBOutlet private weak var labelProfileName: UILabel!
    @IBOutlet private weak var labelProfileEmail: UILabel!
    
    let picker = UIImagePickerController()
    
    // MARK: - Clean Swift properties

    var interactor: ProfileBusinessLogic!
    var router: ProfileRouterLogic!
    
    private var sectionType: SectionsType?
    
    // MARK: - Object lifecycle

    init(sectionType: SectionsType?) {
        super.init(nibName: nil, bundle: nil)
        config()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    private func config() {
        ProfileConfigurator.shared.config(viewController: self)
    }
    
    fileprivate func setupUI() {
        setViews()
    }
    
    private func setViews() {
        self.navigationItem.rightBarButtonItems = [logoutButton]
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        interactor.getUserCredentials()
    }
    
    @IBAction private func viewPoststBtnPressed(_ sender: UIButton) {
        let vc = PostsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func createPoststBtnPressed(_ sender: UIButton) {
        self.present(picker, animated: true, completion: nil)
    }
}

extension ProfileVC: ProfileDisplayLogic {
    func routeToCreatePost(withPhoto: UIImage) {
        let vc = CreatePostsVC(photo: withPhoto)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getUserCredentials(photoUrl: URL, name: String, email: String) {
        imageViewProfile?.downloaded(from: photoUrl)
        labelProfileName.text = name
        labelProfileEmail.text = email
    }
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as! UIImage? {
            router.showDetailView(withPhoto: image)
            self.picker.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - Clean Swift Protocols

protocol ProfileDisplayLogic: class {
    func getUserCredentials(photoUrl: URL, name: String, email: String)
    func routeToCreatePost(withPhoto: UIImage)
}
