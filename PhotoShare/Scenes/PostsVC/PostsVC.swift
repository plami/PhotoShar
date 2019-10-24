//
//  PostsVC.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDWebImage

class PostsVC: UIViewController {

    // MARK: - IBOutlets & Properties
    private var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    private var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    var interactor: PostsBusinessLogic!
    var router: PostsRouterLogic!
    
    var posts: [Post] = []
    
    // MARK: - Object lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
        config()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    private func config() {
       PostsConfigurator.shared.config(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfiguration()
        getPosts()
        showActivityIndicatory()
    }
    
    // MARK: - Firebase Networking

    private func getPosts() {
        let userID = (Auth.auth().currentUser?.uid)!
        PostFirebase.get(userID: userID) { (post) in
            guard let post = post else { return }
            let indexPath = insertSortedByTimestamp(array: &self.posts, item: post)
            self.collectionView?.insertItems(at: [indexPath])
            
            let data = try? Data(contentsOf: self.posts[0].userPhotoURL)

            if let imageData = data {
                let image = UIImage(data: imageData)
                
                let button = UIButton(type: .custom)
                button.backgroundColor = .clear
                button.layer.cornerRadius = 20.0
                button.clipsToBounds = true
                button.layer.borderWidth = 1.5
                button.layer.borderColor = UIColor.black.cgColor
                button.setImage(image, for: .normal)
                let barButtonItem = UIBarButtonItem(customView: button)
                self.navigationItem.rightBarButtonItem = barButtonItem
            }
        }
        navigationItem.title = "\(String(describing: (Auth.auth().currentUser?.displayName)!))'s posts"
    }
    
    // MARK: - Set collectionView

    private func collectionViewConfiguration() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 170, height: 170)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .lightGray
        self.view.addSubview(collectionView)
        self.collectionView.registerCellNib(PostsCollectionViewCell.self)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
     private func showActivityIndicatory() {
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
     private func hideActivityIndicatory() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

extension PostsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PostsCollectionViewCell = collectionView.dequeueCell(at: indexPath)
        let post = posts[indexPath.item]
        cell.configureCell(withPhoto: post.photoURL)
        hideActivityIndicatory()
        return cell
    }
}

extension PostsVC: PostsDisplayLogic {
}

func insertSortedByTimestamp<T: HasTimestamp>(array: inout [T], item: T) -> IndexPath {
    var insertIndex = 0
    for i in 0..<array.count {
        if item.timestamp <= array[i].timestamp {
            if i == array.count - 1 {
                insertIndex = i + 1
            } else {
                if item.timestamp >= array[i+1].timestamp {
                    insertIndex = i + 1
                }
            }
        }
    }
    array.insert(item, at: insertIndex)
    return IndexPath(item: insertIndex, section: 0)
}

// MARK: - Clean Swift Protocols

protocol PostsDisplayLogic: class { }

protocol HasTimestamp {
    var timestamp: Double { get }
}
