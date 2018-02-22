//
//  UserDatabase.swift
//  InstagramClone
//
//  Created by Monika Koschel on 22/02/2018.
//  Copyright © 2018 Monika Koschel. All rights reserved.
//

import Firebase

class UserDatabase {
    
    func getDataForUserWith(id uid: String, then updateUi: @escaping (DataSnapshot) -> (), whenError: @escaping (Error) -> ()) {
        Database.database().reference().child(DatabaseKeys.usersRootKey).child(uid).observeSingleEvent(of: .value, with: {(snapshot: DataSnapshot) in
            DispatchQueue.main.async {
                updateUi(snapshot)
            }
        } ) {(error: Error) in
            DispatchQueue.main.async {
                whenError(error)
            }
        }
    }
    
}
