//
//  InstagramUser.swift
//  InstagramClone
//
//  Created by Monika Koschel on 01/10/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import Foundation

struct InstagramUser {
    let username: String
    let profileImageUrl: String
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
