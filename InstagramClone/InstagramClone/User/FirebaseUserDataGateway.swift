//
//  FirebaseUserDataGateway.swift
//  InstagramClone
//
//  Created by Monika Koschel on 27/09/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import Foundation
import Firebase

class DatabaseKeys {
    static let profileImageUrlKey = "profileImageUrl"
    static let userNameKey = "username"
    static let usersRootKey = "users"
}

class StorageKeys {
    static let profileImagesDirKey = "profile_images"
}

class FirebaseUserDataGateway: UserDataGateway {
    func createUser(userData: UserProfileData) {
        Auth.auth().createUser(withEmail: userData.userMail, password: userData.password) { (user: User?, error: Error?) in
            if let error = error {
                print("Failed to create user", error)
                return
            }
            
            print("Successfully created user", user?.uid ?? "")
            guard let uploadData = UIImageJPEGRepresentation(userData.profilePhoto, 0.3) else { return }
            let fileName = NSUUID().uuidString
            Storage.storage().reference().child(StorageKeys.profileImagesDirKey).child(fileName).putData(uploadData, metadata: nil, completion: { (metadata: StorageMetadata?, error: Error?) in
                if let error = error {
                    print("Failed to upload profile image", error)
                    return
                }
                
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                
                print("Successfully uploaded image", profileImageUrl)
                
                guard let uid = user?.uid else { return }
                let userValues = [DatabaseKeys.userNameKey: userData.userName, DatabaseKeys.profileImageUrlKey: profileImageUrl]
                let values = [uid: userValues]
                
                Database.database().reference().child(DatabaseKeys.usersRootKey).updateChildValues(values, withCompletionBlock: { (error: Error?, dbReference: DatabaseReference?) in
                    if let error = error {
                        print("Failed to save user intfo into db:", error)
                        return
                    }
                    print("Successfully saved user info into db.")
                })
                
            })
            
        }
    }
    
    
}
