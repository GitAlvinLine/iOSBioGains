//
//  LoginViewController.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let emailTextField: UITextField = UITextField()
    
    private var emailPlaceholder: String = ""
    
    convenience init(emailPlaceholder: String) {
        self.init()
        self.emailPlaceholder = emailPlaceholder
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.placeholder = emailPlaceholder
    }
    
}
