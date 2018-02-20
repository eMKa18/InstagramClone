//
//  SignUpView.swift
//  InstagramClone
//
//  Created by Monika Koschel on 20/02/2018.
//  Copyright © 2018 Monika Koschel. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "User name"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        attributedText.append(NSMutableAttributedString(string: "Sign In", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    
    func setup() {
        setupAddPhotoButton()
        setupLoginForm()
        setupAlreadyHaveAccountButton()
    }
    
    func isFormValid() -> Bool {
        let emailLength = emailTextField.text?.count ?? 0
        let userNameLength = userNameTextField.text?.count ?? 0
        let passwordLength = passwordTextField.text?.count ?? 0
        
        return emailLength > 0 && userNameLength > 0 && passwordLength > 0
    }
    
    func getEmail() -> String? {
        return emailTextField.text
    }
    
    func getUsername() -> String? {
        return userNameTextField.text
    }
    
    func getPassword() -> String? {
        return passwordTextField.text
    }
    
    func getProfilePhoto() -> UIImage? {
        return addPhotoButton.imageView?.image
    }
    
    func addActionForSignupButton(_ target: Any?, action: Selector, for event: UIControlEvents) {
        signUpButton.addTarget(target, action: action, for: event)
    }
    
    func addActionForPasswordTextField(_ target: Any?, action: Selector, for event: UIControlEvents) {
        passwordTextField.addTarget(target, action: action, for: event)
    }
    
    func addActionForUsernameTextField(_ target: Any?, action: Selector, for event: UIControlEvents) {
        userNameTextField.addTarget(target, action: action, for: event)
    }
    
    func addActionForEmailTextField(_ target: Any?, action: Selector, for event: UIControlEvents) {
        emailTextField.addTarget(target, action: action, for: event)
    }
    
    func addActionForAlreadyHaveAccountButton(_ target: Any?, action: Selector, for event: UIControlEvents) {
        alreadyHaveAccountButton.addTarget(target, action: action, for: event)
    }
    
    func addActionForAddPhotoButton(_ target: Any?, action: Selector, for event: UIControlEvents) {
        addPhotoButton.addTarget(target, action: action, for: event)
    }
    
    func enableSignUpButton() {
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    }
    
    func disableSignUpButton() {
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }
    
    func setImageInAddPhotoButton(image pickedImage: UIImage) {
        addPhotoButton.setImage(pickedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderColor = UIColor.black.cgColor
        addPhotoButton.layer.borderWidth = 3
    }
    
    private func setupAddPhotoButton() {
        self.addSubview(addPhotoButton)
        addPhotoButton.anchor(top: self.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        addPhotoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func setupLoginForm() {
        let loginFormStackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signUpButton])
        loginFormStackView.distribution = .fillEqually
        loginFormStackView.axis = .vertical
        loginFormStackView.spacing = 10
        self.addSubview(loginFormStackView)
        loginFormStackView.anchor(top: addPhotoButton.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
    }
    
    private func setupAlreadyHaveAccountButton() {
        self.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
}
