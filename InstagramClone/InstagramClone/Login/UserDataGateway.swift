//
//  UserDataGateway.swift
//  InstagramClone
//
//  Created by Monika Koschel on 12/02/2018.
//  Copyright © 2018 Monika Koschel. All rights reserved.
//

import Foundation
import Firebase

protocol UserDataGateway {
    func createUser(userProfileData: UserProfileRegistrationData, updateUIBlock: @escaping () -> ())
    func loginUser(userData: InstagramUserData, updateUIBlock: @escaping () -> ())
    func signOutUser() throws
}

class FirebaseUserDataGateway: UserDataGateway {
    
    func createUser(userProfileData: UserProfileRegistrationData, updateUIBlock: @escaping () -> ()) {
        Auth.auth().createUser(withEmail: userProfileData.userData.mail, password: userProfileData.userData.password) { (user: User?, error: Error?) in
            if let error = error {
                print("Failed to create user", error)
                return
            }
            
            print("Successfully created user", user?.uid ?? "")
            guard let uploadData = UIImageJPEGRepresentation(userProfileData.profilePhoto, 0.3) else { return }
            let fileName = NSUUID().uuidString
            Storage.storage().reference().child(StorageKeys.profileImagesDirKey).child(fileName).putData(uploadData, metadata: nil, completion: { (metadata: StorageMetadata?, error: Error?) in
                if let error = error {
                    print("Failed to upload profile image", error)
                    return
                }
                
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                
                print("Successfully uploaded image", profileImageUrl)
                
                guard let uid = user?.uid else { return }
                let userValues = [DatabaseKeys.userNameKey: userProfileData.userName, DatabaseKeys.profileImageUrlKey: profileImageUrl]
                let values = [uid: userValues]
                
                Database.database().reference().child(DatabaseKeys.usersRootKey).updateChildValues(values, withCompletionBlock: { (error: Error?, dbReference: DatabaseReference?) in
                    if let error = error {
                        print("Failed to save user intfo into db:", error)
                        return
                    }
                    print("Successfully saved user info into db.")
                    DispatchQueue.main.async {
                        updateUIBlock()
                    }
                })
                
            })
            
        }
    }
    
    func loginUser(userData: InstagramUserData, updateUIBlock: @escaping () -> ()) {
        Auth.auth().signIn(withEmail: userData.mail, password: userData.password) { (user, error) in
            if let err = error {
                print("Failed to sign in with email \(userData.mail): ", err)
                return
            }
            
            print("Successfuly logged in with user: ", user?.uid ?? "")
            DispatchQueue.main.async {
                updateUIBlock()
            }
        }
    }
    
    func signOutUser() throws {
        try Auth.auth().signOut()
    }
    
    
}
