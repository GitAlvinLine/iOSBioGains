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
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let app = App(id: "application-0-zyajh")
        if app.currentUser != nil {
            // user is logged in
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = LoginViewController { loginCredentials in
                
            }
            self.window = window
            window.makeKeyAndVisible()
            
        } else {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = LoginViewController { loginCredentials in
                
            }
            self.window = window
            window.makeKeyAndVisible()
        }
    
    }
}
