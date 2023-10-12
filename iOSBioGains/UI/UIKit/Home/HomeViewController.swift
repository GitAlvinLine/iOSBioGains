//
//  HomeViewController.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/19/23.
//

import SwiftUI
import UIKit

class HomeViewController: UIViewController {
    
    let userEmail: UILabel = UILabel()
    let logoutButton: CustomButton = CustomButton(title: "Log Out")
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    let alert: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    let action: UIAlertAction = UIAlertAction(title: "OK", style: .default)
    private let user: User
    var authClient: AuthenticatorClient?
    var router: UINavigationController?
    
    init(user: User, authClient: AuthenticatorClient, router: UINavigationController) {
        self.user = user
        self.authClient = authClient
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("We are not using storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .white : .black
        
        userEmail.text = user.email
        userEmail.textColor = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .black : .white
        userEmail.font = .preferredFont(forTextStyle: .largeTitle)
        userEmail.textAlignment = .center
        userEmail.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(userEmail)
        
        NSLayoutConstraint.activate([
            userEmail.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            userEmail.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            userEmail.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            userEmail.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
        
        self.view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            logoutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
        
        logOutButtonSetup()
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 20),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        self.alert.addAction(action)
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.view.backgroundColor = previousTraitCollection?.userInterfaceStyle == .light ? .black : .white
        self.userEmail.textColor = previousTraitCollection?.userInterfaceStyle == .light ? .white : .black
    }
    
    private func logOutButtonSetup() {
        logoutButton.addTarget(self, action: #selector(logOutUser), for: .touchUpInside)
    }
    
    @objc private func logOutUser() {
        self.startAnimatingLoadingIndicator()
        authClient?.logOut { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.stopAnimatingLoadingIndicator()
                    
                    guard let client = self?.authClient,
                            let router = self?.router else { return }
                    
                    let loginVC = LoginViewController(authClient: client, router: router)
                    let navigationController = UINavigationController(rootViewController: loginVC)
                    navigationController.modalPresentationStyle = .fullScreen
                    self?.present(navigationController, animated: false)
                case .failure(let error):
                    self?.stopAnimatingLoadingIndicator()
                    self?.showAlertError(error)
                }
            }
        }
    }
    
    private func startAnimatingLoadingIndicator() {
        self.loadingIndicator.startAnimating()
    }
    
    private func stopAnimatingLoadingIndicator() {
        self.loadingIndicator.stopAnimating()
    }
    
    private func showAlertError(_ error: Error) {
        self.alert.title = "Error"
        self.alert.message = error.localizedDescription
        self.present(self.alert, animated: true)
    }

}

struct HomeVC_Preview: PreviewProvider {
    
    private final class MockAuthClient: AuthenticatorClient {
        func resetPassword(with email: String, and newPassword: String, completion: @escaping (AuthenticatorClientResult.Reset) -> Void) {
            
        }
        
        func authenticate(with email: String, and password: String, completion: @escaping (Result<User, Error>) -> Void) {
            
        }
        
        func logOut(completion: @escaping (AuthenticatorClientResult.LogOut) -> Void) {
            
        }
        
        func signUp(with email: String, and password: String, completion: @escaping (AuthenticatorClientResult.SignUp) -> Void) {
            
        }
        
        func deleteUser(completion: @escaping (AuthenticatorClientResult.DeleteUser) -> Void) {
            
        }
    }
    
    struct HomeVCView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> HomeViewController {
            let user = User(email: "johnDoe@gmail.com", name: "John Doe")
            let authClient = MockAuthClient()
            return HomeViewController(user: user, authClient: authClient, router: UINavigationController())
        }
        
        func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
            
        }
    }
    
    static var previews: some View {
        HomeVCView()
            .ignoresSafeArea()
    }
}
