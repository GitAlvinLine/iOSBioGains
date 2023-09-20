//
//  LoginViewController.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/11/23.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let loginView: LoginUIView = LoginUIView()
    var tappedLogin: ((LoginCredentials) -> Void)? = nil
    
    convenience init(tappedLogin: @escaping (LoginCredentials) -> Void) {
        self.init()
        self.tappedLogin = tappedLogin
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        self.loginView.emailTextField.delegate = self
        self.loginView.passwordTextField.delegate = self
        self.loginButtonSetup()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginView.emailTextField.resignFirstResponder()
        self.loginView.passwordTextField.resignFirstResponder()
        return true
    }
    
    private func loginButtonSetup() {
        self.loginView.loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
    }
    
    @objc func loginUser() {
        if let email = self.loginView.emailTextField.text,
            let password = self.loginView.passwordTextField.text {
            let credentials = LoginCredentials(email: email, password: password)
            tappedLogin?(credentials)
        } else {
            tappedLogin?(LoginCredentials(email: "", password: ""))
        }
    }
    
}
