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
    var router: UINavigationController?
    
    convenience init(authClient: AuthenticatorClient, router: UINavigationController) {
        self.init()
        self.authClient = authClient
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        self.loginView.emailTextField.delegate = self
        self.loginView.passwordTextField.delegate = self
        self.forgotPasswordButtonSetup()
        self.loginButtonSetup()
        self.signUpButtonSetup()
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
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.stopAnimatingLoadingIndicator()
                    guard let client = self?.authClient, let router = self?.router else { return }
                    let homeVC = HomeViewController(user: user, authClient: client, router: router)
                    self?.router?.setViewControllers([homeVC], animated: true)
                case .failure(let error):
                    self?.stopAnimatingLoadingIndicator()
                    self?.showErrorAlert(error)
                }
            }
        })
    }
    
    private func forgotPasswordButtonSetup() {
        self.loginView.forgotPasswordButton.addTarget(self, action: #selector(showForgotPasswordScreen), for: .touchUpInside)
    }
    
    @objc func showForgotPasswordScreen() {
        guard let client = authClient, let router = self.navigationController else { return }
        let resetPasswordVC = ResetPasswordVC(authClient: client)
        router.pushViewController(resetPasswordVC, animated: true)
    }
    
    private func signUpButtonSetup() {
        self.loginView.signUpButton.addTarget(self, action: #selector(showSignUpScreen), for: .touchUpInside)
    }
    
    @objc func showSignUpScreen() {
        guard let client = authClient, let router = self.navigationController else { return }
        let signUpVC = SignUpVC(authClient: client)
        router.pushViewController(signUpVC, animated: true)
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
