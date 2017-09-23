//
//  ViewController.swift
//  InstagramClone
//
//  Created by Monika Koschel on 23/09/2017.
//  Copyright © 2017 Monika Koschel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "User name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addPhotoButton)
        addPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        setupInputFields()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 20),
                stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
                stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
                stackView.heightAnchor.constraint(equalToConstant: 200)
            ]
        )
    }


}








































