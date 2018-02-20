//
//  ViewController.swift
//  InstagramClone
//
//  Created by Monika Koschel on 23/09/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    let userDataGateway: UserDataGateway
    var myView: SignUpView! {
        return self.view as! SignUpView
    }
    
    init(userGateway: UserDataGateway) {
        userDataGateway = userGateway
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SignUpView()
        myView.setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.backgroundColor = .white
        addActions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func addActions() {
        myView.addActionForSignupButton(self, action: #selector(handleSignUp), for: .touchUpInside)
        myView.addActionForAddPhotoButton(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        myView.addActionForEmailTextField(self, action: #selector(handleTextInputsChanges), for: .editingChanged)
        myView.addActionForPasswordTextField(self, action: #selector(handleTextInputsChanges), for: .editingChanged)
        myView.addActionForUsernameTextField(self, action: #selector(handleTextInputsChanges), for: .editingChanged)
        myView.addActionForAlreadyHaveAccountButton(self, action: #selector(handleShowSignIn), for: .touchUpInside)
    }
    
    @objc private func handleAddPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func handleTextInputsChanges() {
        let isFormValid = myView.isFormValid()
        isFormValid ? myView.enableSignUpButton() : myView.disableSignUpButton()
    }

    @objc private func handleSignUp() {
        guard let email = myView.getEmail(), email.count > 0 else { return }
        guard let userName = myView.getUsername(), userName.count > 0 else { return }
        guard let password = myView.getPassword(), password.count > 0 else { return }
        guard let profilePhoto = myView.getProfilePhoto() else { return }
        let userData = InstagramUserData(mail: email, password: password)
        let profileData = UserProfileRegistrationData(userData: userData, userName: userName, profilePhoto: profilePhoto)
        userDataGateway.createUser(userProfileData: profileData) {
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            mainTabBarController.setupViewControllers()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func handleShowSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image: UIImage? = nil
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            image = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            image = originalImage
        }
        guard let selectedImage = image else { return }
        myView.setImageInAddPhotoButton(image: selectedImage)
        dismiss(animated: true, completion: nil)
    }
    
}
