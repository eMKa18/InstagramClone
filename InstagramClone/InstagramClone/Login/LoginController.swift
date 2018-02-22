//
//  LoginController.swift
//  InstagramClone
//
//  Created by Monika Koschel on 01/10/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    var myView: LoginView! {
        return self.view as! LoginView
    }
    let userDataGateway: UserDataGateway
    let minPasswordLength = 5
    
    init(userGateway: UserDataGateway) {
        userDataGateway = userGateway
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = LoginView()
        myView.setup()
        addActions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc private func handleShowSignUp() {
        let signUpController = SignUpViewController(userGateway: userDataGateway)
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    @objc private func handleTextInputsChanges() {
        myView.isFormValid() ? myView.enableLoginButton() : myView.disableLoginButton()
    }
    
    @objc private func handleLogin() {
        guard let email = myView.getEmail(), email.count > 0 else { return }
        guard let password = myView.getPassword(), password.count > minPasswordLength else { return }
        let instagramUserData = InstagramUserData(mail: email, password: password)
        userDataGateway.loginUser(userData: instagramUserData) {
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            mainTabBarController.setupViewControllers()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func addActions() {
        myView.addActionForLoginButton(self, action: #selector(handleLogin), for: .touchUpInside)
        myView.addActionForEmailTextField(self, action: #selector(handleTextInputsChanges), for: .editingChanged)
        myView.addActionForPasswordTextField(self, action: #selector(handleTextInputsChanges), for: .editingChanged)
        myView.addActionForDontHaveAccountButton(self, action: #selector(handleShowSignUp), for: .touchUpInside)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
