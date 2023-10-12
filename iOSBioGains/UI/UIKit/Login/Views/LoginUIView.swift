//
//  LoginUIView.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/17/23.
//

import SwiftUI
import UIKit

class LoginUIView: UIView {
    
    let emailTextField: CustomTextField = CustomTextField(placeholder: "Email",
                                                          keyboardType: .emailAddress)
    let passwordTextField: CustomTextField = CustomTextField(placeholder: "Password", keyboardType: .default, secureTextEntry: true)
    let loginButton: CustomButton = CustomButton(title: "Login")
    let signUpButton: CustomButton = CustomButton(title: "Sign Up")
    let forgotPasswordButton: UIButton = UIButton(configuration: .borderless())
    let progressIndicator: CustomProgressView = CustomProgressView()
    let alert: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
    let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: .default)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .white : .black
        
        self.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -80),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        self.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor, constant: 0),
            passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor, constant: 60),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(.link, for: .normal)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(forgotPasswordButton)
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        self.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            signUpButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
        
        self.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            loginButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        
        self.addSubview(progressIndicator)
        
        NSLayoutConstraint.activate([
            progressIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            progressIndicator.heightAnchor.constraint(equalToConstant: 20),
            progressIndicator.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        self.alert.addAction(self.alertAction)
        
        
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.backgroundColor = previousTraitCollection?.userInterfaceStyle == .light ? .black : .white
    }
    
}

struct LoginUIViewPreview: PreviewProvider {
    struct LoginUIViewRepresentable: UIViewRepresentable {
        
        func makeUIView(context: Context) -> LoginUIView {
            return LoginUIView()
        }
        
        func updateUIView(_ uiView: LoginUIView, context: Context) {}
    }
    
    static var previews: some View {
        LoginUIViewRepresentable()
            .ignoresSafeArea(.all)
            .preferredColorScheme(.dark)
    }
}
