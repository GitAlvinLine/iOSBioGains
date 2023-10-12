//
//  ResetPasswordVC.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 10/11/23.
//

import UIKit

class ResetPasswordVC: UIViewController, UITextFieldDelegate {
    
    private let email: CustomTextField = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
    private let newPassword: CustomTextField = CustomTextField(placeholder: "New Password", keyboardType: .default)
    private let resetPasswordButton: CustomButton = CustomButton(title: "Reset Password")
    private let progressIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private let alertVC: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    private let action: UIAlertAction = UIAlertAction(title: "OK", style: .default)
    
    private var authClient: AuthenticatorClient?
    
    convenience init(authClient: AuthenticatorClient) {
        self.init()
        self.authClient = authClient
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.view.backgroundColor = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .white : .black
        
        email.delegate = self
        newPassword.delegate = self
        
        email.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(email)
        
        NSLayoutConstraint.activate([
            email.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            email.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80),
            email.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            email.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
            
        ])
        
        newPassword.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(newPassword)
        
        NSLayoutConstraint.activate([
            newPassword.centerXAnchor.constraint(equalTo: email.centerXAnchor, constant: 0),
            newPassword.centerYAnchor.constraint(equalTo: email.centerYAnchor, constant: 60),
            newPassword.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            newPassword.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        self.view.addSubview(resetPasswordButton)
        
        NSLayoutConstraint.activate([
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 50),
            resetPasswordButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            resetPasswordButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            resetPasswordButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
        
        setUpResetPasswordButton()
        
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(progressIndicator)
        
        NSLayoutConstraint.activate([
            progressIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            progressIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
        alertVC.addAction(action)
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.view.backgroundColor = previousTraitCollection?.userInterfaceStyle == .light ? .black : .white
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        newPassword.resignFirstResponder()
        return true
    }
    
    private func setUpResetPasswordButton() {
        resetPasswordButton.addTarget(self, action: #selector(tappedSendPasswordResetLink), for: .touchUpInside)
    }
    
    @objc func tappedSendPasswordResetLink() {
        startAnimatingProgressIndicator()
        guard let email = email.text, let newPassword = newPassword.text else { return }
        authClient?.resetPassword(with: email, and: newPassword) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.stopAnimatingProgressIndicator()
                    self?.showPasswordResetLinkSuccessAlert()
                case .failure(let error):
                    self?.stopAnimatingProgressIndicator()
                    self?.showAlertError(error)
                }
            }
        }
    }
    
    private func startAnimatingProgressIndicator() {
        progressIndicator.startAnimating()
    }
    
    private func stopAnimatingProgressIndicator() {
        progressIndicator.stopAnimating()
    }
    
    private func showPasswordResetLinkSuccessAlert() {
        self.alertVC.title = "Success!"
        self.alertVC.message = "You have reset your password. You can login now with new password."
        self.present(alertVC, animated: true)
    }
    
    private func showAlertError(_ error: Error) {
        alertVC.title = "Error"
        alertVC.message = error.localizedDescription
        self.present(alertVC, animated: true)
    }

}
