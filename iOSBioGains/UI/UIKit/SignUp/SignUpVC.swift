//
//  SignUpVC.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 10/11/23.
//

import SwiftUI
import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {

    let email: CustomTextField = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
    let password: CustomTextField = CustomTextField(placeholder: "Password", keyboardType: .default)
    let signUpButton: CustomButton = CustomButton(title: "Sign Up")
    let progressIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    let alertVC: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    let action: UIAlertAction = UIAlertAction(title: "OK", style: .default)
    
    private var authClient: AuthenticatorClient?
    
    convenience init(authClient: AuthenticatorClient) {
        self.init()
        self.authClient = authClient
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.email.delegate = self
        self.password.delegate = self
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.view.backgroundColor = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .white : .black
        
        self.view.addSubview(email)
        
        NSLayoutConstraint.activate([
            email.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            email.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80),
            email.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            email.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        self.view.addSubview(password)
        
        NSLayoutConstraint.activate([
            password.centerXAnchor.constraint(equalTo: email.centerXAnchor, constant: 0),
            password.centerYAnchor.constraint(equalTo: email.centerYAnchor, constant: 60),
            password.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        self.view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            signUpButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        setUpSignUpButton()
        
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(progressIndicator)
        
        NSLayoutConstraint.activate([
            progressIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            progressIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            progressIndicator.heightAnchor.constraint(equalToConstant: 20),
            progressIndicator.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        alertVC.addAction(action)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.view.backgroundColor = previousTraitCollection?.userInterfaceStyle == .light ? .black : .white
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.email.resignFirstResponder()
        self.password.resignFirstResponder()
        return true
    }
    
    private func setUpSignUpButton() {
        signUpButton.addTarget(self, action: #selector(tappedSignUp), for: .touchUpInside)
    }
    
    @objc func tappedSignUp() {
        startAnimatingProgressIndicator()
        if let email = email.text, let password = password.text {
            authClient?.signUp(with: email, and: password, completion: { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self?.logUser(with: email, and: password)
                    case .failure(let error):
                        self?.stopAnimatingProgressIndicator()
                        self?.showAlertError(error)
                    }
                }
            })
        }
    }
    
    private func logUser(with email: String, and password: String) {
        authClient?.authenticate(with: email, and: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    guard let client = self?.authClient, let router = self?.navigationController else { return }
                    let tabbar = UITabBarController()
                    
                    let user = User(email: user.email, name: user.name)
                    let homeVC = HomeViewController(user: user, authClient: client, router: router)
                    let trainerVC = TrainerChatVC()
                    
                    let profileNavigation = UINavigationController(rootViewController: homeVC)
                    let personalTrainerNavigation = UINavigationController(rootViewController: trainerVC)
                    
                    profileNavigation.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill")!, tag: 1)
                    personalTrainerNavigation.tabBarItem = UITabBarItem(title: "Trainer", image: UIImage(systemName: "figure.strengthtraining.traditional")!, tag: 0)
                    
                    tabbar.viewControllers = [personalTrainerNavigation, profileNavigation]
                    tabbar.selectedIndex = 1
                    
                    tabbar.modalPresentationStyle = .fullScreen
                    
                    self?.present(tabbar, animated: false)
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
    
    private func showAlertError(_ error: Error) {
        self.alertVC.title = "Error"
        self.alertVC.message = error.localizedDescription
        self.present(alertVC, animated: true)
    }

}

struct SignUpVC_Preview: PreviewProvider {
    struct SignUpVCView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> SignUpVC {
            return SignUpVC()
        }
        
        func updateUIViewController(_ uiViewController: SignUpVC, context: Context) {
            
        }
    }
    
    static var previews: some View {
        SignUpVCView()
            .ignoresSafeArea(.all)
            .preferredColorScheme(.dark)
    }
}
