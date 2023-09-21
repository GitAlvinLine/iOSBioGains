//
//  SceneDelegate.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/10/23.
//

import RealmSwift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private enum StateManager {
        case loggedIn
        case loggedOut
    }
    
    private var state: StateManager = .loggedOut
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        displayWindow(windowScene)
        
    }
    
    private func displayWindow(_ windowScene: UIWindowScene) {
        let authenticator: AuthenticatorClient = RealmAuthenticatorClient()
        
        let app = App(id: "application-0-zyajh")
        
        if app.currentUser != nil {
            // user is logged in
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = HomeViewController {
                // user tapped log out
                print("Log Out User was tapped")
                app.currentUser?.logOut(completion: { [weak self] error in
                    DispatchQueue.main.async {
                        if let error = error {
                            print("error")
                        } else {
                            self?.window?.rootViewController = LoginViewController { _ in
                                self?.displayWindow(windowScene)
                            }
                        }
                    }
                })
            }
            self.window = window
            window.makeKeyAndVisible()
            
        } else {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = LoginViewController { loginCredentials in
                print("login credentials was tapped")
                authenticator.authenticate(with: loginCredentials.email, and: loginCredentials.password) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case.success(_):
                            self?.window?.rootViewController = HomeViewController {
                                self?.displayWindow(windowScene)
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
