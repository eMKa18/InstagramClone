//
//  ProfileData.swift
//  InstagramClone
//
//  Created by Monika Koschel on 27/09/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import UIKit

class UserProfileData {
    var userMail: String
    var userName: String
    var password: String
    var profilePhoto: UIImage
    
    init(email: String, userName: String, password: String, profilePhoto: UIImage) {
        self.userMail = email
        self.userName = userName
        self.password = password
        self.profilePhoto = profilePhoto
    }
}
