//
//  PostFirebase.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 11.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class PostFirebase {
    
    class func createPost(image: UIImage, postText: String, completion: @escaping (Bool) -> ()) {
        
        let postRef = Database.database().reference().child("posts").childByAutoId()
        let fileName = postRef.key! + ".jpg"
        let storageRef = Storage.storage().reference().child("postImages").child(fileName)
        guard let data = image.jpegData(compressionQuality: 0.75) else { completion(false); return }
        storageRef.putData(data, metadata: nil) { (metadata, error) in
            if error == nil {
                storageRef.downloadURL { url, error in
                    print("Image URL: \((url?.absoluteString)!)")
                    guard let userID =  Auth.auth().currentUser?.uid
                        else {completion(false); return }
                    let postObject: [String: Any] = [
                        "photoURL": url?.absoluteString as Any,
                        "postText": postText,
                        "userID": userID,
                        "userPhotoURL": Auth.auth().currentUser?.photoURL?.absoluteString as Any,
                        "timestamp": Date().timeIntervalSinceReferenceDate
                    ]
                    postRef.setValue(postObject)
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
    
    class func get(userID: String, completion: @escaping (Post?)->Void ) {
        let postRef = Database.database().reference().child("posts")
        postRef.queryOrdered(byChild: "userID").queryEqual(toValue: userID).observe(.childAdded) { (snapshot) in
            let postDictionary = snapshot.value as? [String: Any]
            let post = Post(postDictionary: postDictionary)
            completion(post)
        }
    }
}
