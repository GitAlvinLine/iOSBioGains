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
    
    private
    convenience init(tappedLogin: @escaping (LoginCredentials) -> Void) {
        self.init()
        self.tappedLogin = tappedLogin
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        self.loginView.emailTextField.delegate = self
        self.loginView.passwordTextField.delegate = self
    }
    
}
