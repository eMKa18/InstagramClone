//
//  UserProfileController.swift
//  InstagramClone
//
//  Created by Monika Koschel on 28/09/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        fetchUser()
    }
    
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child(DatabaseKeys.usersRootKey).child(uid).observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) in
                print(snapshot.value ?? "")
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let username = dictionary["username"] as? String
            self.navigationItem.title = username
            
            
            }) { (error: Error) in
                print("Failed to fetch user:", error)
            }
        }
}
