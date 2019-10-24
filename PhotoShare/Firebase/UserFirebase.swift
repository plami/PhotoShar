//
//  UserFirebase.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 3.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation
import FirebaseAuth
import FBSDKLoginKit
import FirebaseDatabase

class UserFirebase {
    
    static let userRef = Database.database().reference().child("users")
    
    class func signIn(result: LoginManagerLoginResult, completion: @escaping (Bool) -> ()) {
        let credential = FacebookAuthProvider.credential(withAccessToken: (result.token!.tokenString))
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print(error.debugDescription)
                completion(false)
            } else {
                print(user?.description ?? "")
                storeUser(user: user?.user)
                completion(true)
            }
        }
    }
    
    class func signin(token: AccessToken, completion: @escaping (Bool)-> ()) {
        let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print(error.debugDescription)
                completion(false)
            } else {
                storeUser(user: user?.user)
                completion(true)
            }
        }
    }
    
    class func signout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error)
        }
    }
    
    class func storeUser(user: User?) {
        guard let user = user else { return }
        userRef.child(user.uid).child("name").setValue(user.displayName)
        userRef.child(user.uid).child("photoURL").setValue(user.photoURL?.absoluteString)
        userRef.child(user.uid).child("userID").setValue(user.uid)
    }
    
    class func searchUsers(text: String?, completion: @escaping ([PFUser])-> ()) {
        guard let text = text,
            let currentUser = Auth.auth().currentUser else { completion([]); return}
        userRef.queryOrdered(byChild: "name").queryStarting(atValue: text).queryEnding(atValue: text + "~").observeSingleEvent(of: .value) { (snapshot) in
            let enumerator = snapshot.children
            var optionalUserDictionaries: [[String: Any]?] = []
            while let child = enumerator.nextObject() as? DataSnapshot {
                let userDictionary = child.value as? [String: Any]
                optionalUserDictionaries.append(userDictionary)
            }
            let foundUsers = optionalUserDictionaries.compactMap({ (userDictionary) -> PFUser? in
                let user = PFUser.init(userDictionary: userDictionary)
                if let invites = userDictionary?["invites"] as? [String: Any],
                    invites.keys.contains(currentUser.uid) {
                    user?.isInvited = true
                }
                if let friends = userDictionary?["friends"] as? [String: Any],
                    friends.keys.contains(currentUser.uid) {
                    user?.isFriend = true
                }
                if userDictionary?["friends"] == nil {
                    user?.isFriend = false
                }
                if userDictionary?["invites"] == nil {
                    user?.isInvited = false
                }
                return user
            })
            completion(foundUsers)
        }
    }
    
    class func invite(userID: String, completion: @escaping (Bool)-> ()) {
        guard let currentUser = Auth.auth().currentUser else { completion(false); return}
        let userObject: [String: String] = [
            "name": currentUser.displayName ?? "",
            "photoURL": currentUser.photoURL?.absoluteString ?? "",
            "userID": currentUser.uid
        ]
        userRef.child(userID).child("invites").child(currentUser.uid).setValue(userObject)
        completion(true)
    }
    
    class func uninvite(userID: String, completion: @escaping (Bool)->()) {
        guard let currentUser = Auth.auth().currentUser else { completion(false); return}
        userRef.child(userID).child("invites").child(currentUser.uid).setValue(nil)
        completion(true)
    }
    
    class func observeUsers(type: String, event: DataEventType, completion: @escaping (PFUser?)-> ()) {
        guard let user = Auth.auth().currentUser else { completion(nil); return}
        userRef.child(user.uid).child(type).observe(event) { (snapshot) in
            let userDictionary = snapshot.value as? [String: Any]
            let userObject = PFUser.init(userDictionary: userDictionary)
            completion(userObject)
        }
    }
    
    class func acceptInvite(userObject: PFUser, completion: @escaping (Bool)->()) {
        guard let user = Auth.auth().currentUser else { completion(false); return}
        userRef.child(user.uid).child("invites").child(userObject.userID).setValue(nil)
        let userDictionary = [
            "name": userObject.name,
            "photoURL": userObject.photoURL.absoluteString,
            "userID": userObject.userID
        ]
        userRef.child(user.uid).child("friends").child(userObject.userID).setValue(userDictionary)
        let currentUserDictionary = [
            "name": user.displayName,
            "photoURL": user.photoURL?.absoluteString,
            "userID": user.uid
        ]
        userRef.child(userObject.userID).child("friends").child(user.uid).setValue(currentUserDictionary)
        completion(true)
    }
    
    class func declineInvite(userObject: PFUser, completion: @escaping (Bool)->()) {
        guard let user = Auth.auth().currentUser else { completion(false); return}
        userRef.child(user.uid).child("invites").child(userObject.userID).setValue(nil)
        completion(true)
    }
}

enum SectionsType {
    
    case profile
    case friends
    case posts
}

