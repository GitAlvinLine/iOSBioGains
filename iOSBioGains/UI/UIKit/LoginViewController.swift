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
    
    private var emailPlaceholder: String = ""
    private var passwordPlaceholder: String = ""
    
    convenience init(emailPlaceholder: String, passwordPlaceholder: String) {
        self.init()
        self.emailPlaceholder = emailPlaceholder
        self.passwordPlaceholder = passwordPlaceholder
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPlaceholders(for: [emailTextField, passwordTextField], with: ["Email", "Password"])
    }
    
    private func setPlaceholders(for textFields: [UITextField], with values: [String]) {
        for index in textFields.indices {
            textFields[index].placeholder = values[index]
        }
    }
    
}
