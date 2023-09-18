//
//  LoginViewController.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView: UIView = LoginUIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
    }
    
}
