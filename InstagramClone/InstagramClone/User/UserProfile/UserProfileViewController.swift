//
//  UserProfileViewController.swift
//  InstagramClone
//
//  Created by Monika Koschel on 28/09/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UICollectionViewController {
    
    var user: InstagramUser?
    let headerId = "userProfileHeader"
    let cellId = "userProfileCell"
    let cellSpacing: CGFloat = 1
    let numberOfColumnsInGrid: CGFloat = 3
    let userDataGateway: UserDataGateway
    let userDatabase = UserDatabase()
    
    init(collectionViewLayout: UICollectionViewLayout, userGateway: UserDataGateway) {
        userDataGateway = userGateway
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchUser()
        registerHeader()
        registerCell()
        
        setupLogOutButton()
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

    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        userDatabase.getDataForUserWith(id: uid, then: { (snapshot: DataSnapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            self.user = InstagramUser(dictionary: dictionary)
            self.navigationItem.title = self.user?.username
            self.collectionView?.reloadData()
        }) { (error: Error) in
            print("Failed to fetch user:", error)
        }
//        Database.database().reference().child(DatabaseKeys.usersRootKey).child(uid).observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) in
//                guard let dictionary = snapshot.value as? [String: Any] else { return }
//                self.user = InstagramUser(dictionary: dictionary)
//                self.navigationItem.title = self.user?.username
//                self.collectionView?.reloadData()
//            }) { (error: Error) in
//                print("Failed to fetch user:", error)
//            }
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
    
    private func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    @objc private func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: UserProfileStrings.logoutButtonTitle, style: .destructive, handler: { (_) in
            do {
                try self.userDataGateway.signOutUser()
                let loginController = LoginController(userGateway: self.userDataGateway)
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            } catch let signOutError {
                print("Failed to sign out...", signOutError)
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: UserProfileStrings.cancelButtonTitle, style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension UserProfileViewController: UICollectionViewDelegateFlowLayout {
    
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
}







