//
//  LoginViewController.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let emailTextField: UITextField = UITextField()
    let passwordTextField: UITextField = UITextField()
    let loginButton: UIButton = UIButton()
    
    private var emailPlaceholder: String = ""
    private var passwordPlaceholder: String = ""
    private var loginButtonText: String = ""
    
    convenience init(emailPlaceholder: String, passwordPlaceholder: String, loginButtonText: String) {
        self.init()
        self.emailPlaceholder = emailPlaceholder
        self.passwordPlaceholder = passwordPlaceholder
        self.loginButtonText = loginButtonText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPlaceholders(for: [emailTextField, passwordTextField], with: ["Email", "Password"])
        
        loginButton.setTitle(loginButtonText, for: .normal)
        
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
    }
    
    private func setPlaceholders(for textFields: [UITextField], with values: [String]) {
        for index in textFields.indices {
            textFields[index].placeholder = values[index]
        }
    }
    
}
