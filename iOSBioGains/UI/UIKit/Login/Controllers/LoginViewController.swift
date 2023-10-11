//
//  LoginViewController.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/11/23.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let loginView: LoginUIView = LoginUIView()
    var authClient: AuthenticatorClient?
    var loginSuccess: ((User) -> Void)? = nil
    
    convenience init(authClient: AuthenticatorClient, loginSuccess: @escaping (User) -> Void) {
        self.init()
        self.authClient = authClient
        self.loginSuccess = loginSuccess
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
        self.startAnimatingLoadingIndicator()
        let email = self.loginView.emailTextField.text
        let password = self.loginView.passwordTextField.text
        let credentials = LoginCredentials(email: email ?? "", password: password ?? "")
        authClient?.authenticate(with: credentials.email, and: credentials.password, completion: { [weak self] result in
            switch result {
            case .success(let user):
                self?.stopAnimatingLoadingIndicator()
                self?.loginSuccess?(user)
            case .failure(let error):
                self?.stopAnimatingLoadingIndicator()
                self?.showErrorAlert(error)
            }
        })
    }
    
    private func startAnimatingLoadingIndicator() {
        self.loginView.progressIndicator.startAnimating()
    }
    
    private func stopAnimatingLoadingIndicator() {
        self.loginView.progressIndicator.stopAnimating()
    }
    
    private func showErrorAlert(_ error: Error) {
        self.loginView.alert.title = "Error"
        self.loginView.alert.message = error.localizedDescription
        self.present(self.loginView.alert, animated: true)
    }
    
}
