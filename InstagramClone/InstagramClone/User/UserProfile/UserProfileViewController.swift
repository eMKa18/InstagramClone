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
    let cellId = "cellId"
    let cellSpacing: CGFloat = 1
    let numberOfColumnsInGrid: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchUser()
        registerHeader()
        registerCell()
    }

    override func collectionView(_ collectionView : UICollectionView, viewForSupplementaryElementOfKind kind : String,
                                  at indexPath : IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! UserProfileHeader
        header.user = user
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2 * cellSpacing) / numberOfColumnsInGrid
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout,
                         referenceSizeForHeaderInSection section : Int) -> CGSize {
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
    
    private func setupView() {
        collectionView?.backgroundColor = .white
    }
    
    private func registerHeader() {
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    private func registerCell() {
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
}
