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
        let app = App(id: "application-0-zyajh")
        let realmAuthClient: AuthenticatorClient = RealmAuthenticatorClient()
        let router = UINavigationController()
        
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        if let user = app.currentUser {
            let user = User(email: user.profile.email ?? "", name: user.profile.name ?? "")
            let homeVC = HomeViewController(user: user, authClient: realmAuthClient, router: router)
            router.viewControllers = [homeVC]
            self.window?.rootViewController = router
            self.window?.makeKeyAndVisible()
        } else {
            let loginVC = LoginViewController(authClient: realmAuthClient, router: router)
            router.viewControllers = [loginVC]
            self.window?.rootViewController = router
            self.window?.makeKeyAndVisible()
        }
        
    }

}

final class AuthStateViewController: UIViewController {
    var loginVC: LoginViewController?
    var homeVC: HomeViewController?
    var authManager: AuthStateManager?
    
    convenience init(loginVC: LoginViewController, homeVC: HomeViewController, authManager: AuthStateManager) {
        self.init()
        self.loginVC = loginVC
        self.homeVC = homeVC
        self.authManager = authManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch authManager?.state {
        case .loggedOut:
            self.present(loginVC!, animated: true)
        case .loggedIn(let user):
            homeVC?.user = user
            self.present(homeVC!, animated: true)
        case .unauthenticated:
            self.present(UIViewController(), animated: false)
        case .none:
            break
        }
    }
}


final class AuthStateManager: ObservableObject {
    @Published var state: State = .unauthenticated
    
    private let app = App(id: "application-0-zyajh")
    
    enum State {
        case unauthenticated
        case loggedIn(User)
        case loggedOut
    }
    
    init() {
        setUserState()
    }
    
    private func setUserState() {
        if let user = app.currentUser {
            let user = User(email: user.profile.email ?? "", name: user.profile.name ?? "")
            state = .loggedIn(user)
        } else {
            state = .loggedOut
        }
    }
}
