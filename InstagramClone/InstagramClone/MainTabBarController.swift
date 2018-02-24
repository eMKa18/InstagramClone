//
//  MainTabBarControler.swift
//  InstagramClone
//
//  Created by Monika Koschel on 28/09/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let userDataGateway: UserDataGateway
    
    init(userGateway: UserDataGateway) {
        userDataGateway = userGateway
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let indexOfAddingPhotoController = 2
        let index = viewControllers?.index(of: viewController)
        if index == indexOfAddingPhotoController {
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            present(navController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
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
        let homeNavController = createTemplateNavController(withUnselected: #imageLiteral(resourceName: "home_unselected"), andSelected: #imageLiteral(resourceName: "home_selected"))
        let searchNavController = createTemplateNavController(withUnselected: #imageLiteral(resourceName: "search_unselected"), andSelected: #imageLiteral(resourceName: "search_selected"))
        let plusNavController = createTemplateNavController(withUnselected: #imageLiteral(resourceName: "plus_unselected"), andSelected: #imageLiteral(resourceName: "plus_unselected"))
        let likeNavController = createTemplateNavController(withUnselected: #imageLiteral(resourceName: "like_unselected"), andSelected: #imageLiteral(resourceName: "like_selected"))
        let layout = UICollectionViewFlowLayout()
        let userProfileViewController = UserProfileViewController(collectionViewLayout: layout, userGateway: userDataGateway)
        let profileNavController = UINavigationController(rootViewController: userProfileViewController)
        profileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        profileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .black

        viewControllers = [homeNavController, searchNavController, plusNavController, likeNavController, profileNavController]
        
        guard let tabBarItems = tabBar.items else { return }
        tabBarItems.forEach { (item) in
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    private func createTemplateNavController(withUnselected unselectedImage: UIImage, andSelected selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
