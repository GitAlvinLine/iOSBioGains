//
//  LoginViewController.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView: LoginUIView = LoginUIView()
    var tappedLogin: ((LoginCredentials) -> Void)? = nil
    
    convenience init(tappedLogin: @escaping (LoginCredentials) -> Void) {
        self.init()
        self.tappedLogin = tappedLogin
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
    }
    
}
