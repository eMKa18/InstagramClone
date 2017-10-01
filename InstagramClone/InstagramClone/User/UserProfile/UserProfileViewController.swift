//
//  UserProfileViewController.swift
//  InstagramClone
//
//  Created by Monika Koschel on 28/09/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user: InstagramUser?
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        fetchUser()
        registerHeader()
    }

    override func collectionView( _ collectionView : UICollectionView, viewForSupplementaryElementOfKind kind : String,
                                  at indexPath : IndexPath ) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! UserProfileHeader
        header.user = user
        return header
    }

    func collectionView( _ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout,
                         referenceSizeForHeaderInSection section : Int ) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }

    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child(DatabaseKeys.usersRootKey).child(uid).observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                self.user = InstagramUser(dictionary: dictionary)
                self.navigationItem.title = self.user?.username
                self.collectionView?.reloadData()
            }) { (error: Error) in
                print("Failed to fetch user:", error)
            }
    }
    
    private func registerHeader() {
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
}


struct InstagramUser {
    let username: String
    let profileImageUrl: String
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
