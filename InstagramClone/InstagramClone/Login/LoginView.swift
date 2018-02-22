//
//  LoginView.swift
//  InstagramClone
//
//  Created by Monika Koschel on 22/02/2018.
//  Copyright © 2018 Monika Koschel. All rights reserved.
//

import UIKit

class LoginView: UIView {

    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        attributedText.append(NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    
    private let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
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
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    func setup() {
        self.backgroundColor = .white
        setupSignUpButton()
        setupLogoView()
        setupInputFields()
    }
    
    func isFormValid() -> Bool {
        let emailLength = emailTextField.text?.count ?? 0
        let passwordLength = passwordTextField.text?.count ?? 0
        return emailLength > 0 && passwordLength > 0
    }
    
    func getEmail() -> String? {
        return emailTextField.text
    }
    
    func getPassword() -> String? {
        return passwordTextField.text
    }
    
    func addActionForDontHaveAccountButton(_ target: Any?, action: Selector, for event: UIControlEvents) {
        dontHaveAccountButton.addTarget(target, action: action, for: event)
    }
    
    func addActionForEmailTextField(_ target: Any?, action: Selector, for event: UIControlEvents) {
        emailTextField.addTarget(target, action: action, for: event)
    }
    
    func addActionForPasswordTextField(_ target: Any?, action: Selector, for event: UIControlEvents) {
        passwordTextField.addTarget(target, action: action, for: event)
    }
    
    func addActionForLoginButton(_ target: Any?, action: Selector, for event: UIControlEvents) {
        loginButton.addTarget(target, action: action, for: event)
    }
    
    func enableLoginButton() {
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    }
    
    func disableLoginButton() {
        loginButton.isEnabled = false
        loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }
    
    private func setupSignUpButton() {
        self.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    private func setupLogoView() {
        self.addSubview(logoContainerView)
        logoContainerView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
    }
    
    private func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
    }

}
