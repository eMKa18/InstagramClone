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
    
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInputsChanges), for: .editingChanged)
        return textField
    }()
    
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "User name"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInputsChanges), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInputsChanges), for: .editingChanged)
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        attributedText.append(NSMutableAttributedString(string: "Sign In", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAddPhotoButton()
        setupLoginForm()
        setupAlreadyHaveAccountButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func handleAddPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func handleTextInputsChanges() {
        let emailLength = emailTextField.text?.count ?? 0
        let userNameLength = userNameTextField.text?.count ?? 0
        let passwordLength = passwordTextField.text?.count ?? 0
        
        let isFormValid = emailLength > 0 && userNameLength > 0 && passwordLength > 0
        isFormValid ? enableSignUpButton() : disableSignUpButton()
    }

    @objc private func handleSignUp() {
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let userName = userNameTextField.text, userName.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        guard let profilePhoto = addPhotoButton.imageView?.image else { return }
        let profileData = UserProfileRegistrationData(userMail: email, userName: userName, password: password, profilePhoto: profilePhoto)
        Auth.auth().createUser(withEmail: profileData.userMail, password: profileData.password) { (user: User?, error: Error?) in
            if let error = error {
                print("Failed to create user", error)
                return
            }
            
            print("Successfully created user", user?.uid ?? "")
            guard let uploadData = UIImageJPEGRepresentation(profileData.profilePhoto, 0.3) else { return }
            let fileName = NSUUID().uuidString
            Storage.storage().reference().child(StorageKeys.profileImagesDirKey).child(fileName).putData(uploadData, metadata: nil, completion: { (metadata: StorageMetadata?, error: Error?) in
                if let error = error {
                    print("Failed to upload profile image", error)
                    return
                }
                
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                
                print("Successfully uploaded image", profileImageUrl)
                
                guard let uid = user?.uid else { return }
                let userValues = [DatabaseKeys.userNameKey: profileData.userName, DatabaseKeys.profileImageUrlKey: profileImageUrl]
                let values = [uid: userValues]
                
                Database.database().reference().child(DatabaseKeys.usersRootKey).updateChildValues(values, withCompletionBlock: { (error: Error?, dbReference: DatabaseReference?) in
                    if let error = error {
                        print("Failed to save user intfo into db:", error)
                        return
                    }
                    print("Successfully saved user info into db.")
                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
                    mainTabBarController.setupViewControllers()
                    self.dismiss(animated: true, completion: nil)
                })
                
            })
            
        }
    }
    
    @objc private func handleShowSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupAddPhotoButton() {
        view.addSubview(addPhotoButton)
        addPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupLoginForm() {
        let loginFormStackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signUpButton])
        loginFormStackView.distribution = .fillEqually
        loginFormStackView.axis = .vertical
        loginFormStackView.spacing = 10
        view.addSubview(loginFormStackView)
        loginFormStackView.anchor(top: addPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
    }
    
    private func setupAlreadyHaveAccountButton() {
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    private func enableSignUpButton() {
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    }
    
    private func disableSignUpButton() {
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }
    
    private func setImageInAddPhotoButton(_ pickedImage: UIImage) {
        addPhotoButton.setImage(pickedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderColor = UIColor.black.cgColor
        addPhotoButton.layer.borderWidth = 3
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
        setImageInAddPhotoButton(selectedImage)
        dismiss(animated: true, completion: nil)
    }
}
