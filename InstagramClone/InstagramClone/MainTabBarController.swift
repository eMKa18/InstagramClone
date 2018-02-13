//
//  MainTabBarControler.swift
//  InstagramClone
//
//  Created by Monika Koschel on 28/09/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    let userDataGateway: UserDataGateway
    
    init(userGateway: UserDataGateway) {
        userDataGateway = userGateway
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController(userGateway: self.userDataGateway)
                let navigationController = UINavigationController(rootViewController: loginController)
                self.present(navigationController, animated: true, completion: nil)
            }
            return
        }
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        let layout = UICollectionViewFlowLayout()
        let userProfileViewController = UserProfileViewController(collectionViewLayout: layout, userGateway: userDataGateway)
        
        let navController = UINavigationController(rootViewController: userProfileViewController)
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        tabBar.tintColor = .black
        let dummyViewController = UIViewController()
        viewControllers = [navController, dummyViewController]
    }
}
