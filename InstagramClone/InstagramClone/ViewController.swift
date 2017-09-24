//
//  ViewController.swift
//  InstagramClone
//
//  Created by Monika Koschel on 23/09/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInputChanges), for: .editingChanged)
        return textField
    }()
    
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "User name"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInputChanges), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInputChanges), for: .editingChanged)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddPhotoButton()
        setupLoginForm()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func handleTextInputChanges() {
        let emailLength = emailTextField.text?.characters.count ?? 0
        let userNameLength = userNameTextField.text?.characters.count ?? 0
        let passwordLength = passwordTextField.text?.characters.count ?? 0
        
        let isFormValid = emailLength > 0 && userNameLength > 0 && passwordLength > 0
        if isFormValid {
            enableSignUpButton()
        } else {
            disableSignUpButton()
        }
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text, email.characters.count > 0 else { return }
        guard let userName = userNameTextField.text, userName.characters.count > 0 else { return }
        guard let password = passwordTextField.text, password.characters.count > 0 else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error: Error?) in
            if let error = error {
                print("Failed to create user", error)
                return
            }
            
            print("Successfully created user", user?.uid ?? "")
        }
    }
    
    fileprivate func setupAddPhotoButton() {
        view.addSubview(addPhotoButton)
        addPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    fileprivate func setupLoginForm() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: addPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
    }
    
    fileprivate func enableSignUpButton() {
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    }
    
    fileprivate func disableSignUpButton() {
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }
}








































