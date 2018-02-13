//
//  ProfileData.swift
//  InstagramClone
//
//  Created by Monika Koschel on 27/09/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import UIKit

struct InstagramUserData {
    var mail: String
    var password: String
}

struct UserProfileRegistrationData {
    var userData: InstagramUserData
    var userName: String
    var profilePhoto: UIImage
}
