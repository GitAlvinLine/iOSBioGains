//
//  RealmAuthenticatorClient.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/19/23.
//

import RealmSwift
import Foundation

class RealmAuthenticatorClient: AuthenticatorClient {
    private let app = App(id: "application-0-zyajh")
    
    init() {}
    
    func authenticate(with email: String, and password: String, completion: @escaping (Result<User, Error>) -> Void) {
        app.login(credentials: Credentials.emailPassword(email: email, password: password)) { result in
            switch result {
            case .success(let user):
                if let email = user.profile.email {
                    let appUser: User = User(email: email, name: "")
                    completion(.success(appUser))
                } else {
                    completion(.success(User(email: "", name: "")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func logOut(completion: @escaping (AuthenticatorClientResult.LogOut) -> Void)  {
        app.currentUser?.logOut { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success)
            }
        }
    }
    
    func signUp(with email: String, and password: String, completion: @escaping (AuthenticatorClientResult.SignUp) -> Void) {
        app.emailPasswordAuth.registerUser(email: email, password: password) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success)
            }
        }
    }
    
    func resetPassword(with email: String, completion: @escaping (AuthenticatorClientResult.Reset) -> Void) {
        app.emailPasswordAuth.sendResetPasswordEmail(email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success)
            }
        }
    }
    
    func deleteUser(completion: @escaping (AuthenticatorClientResult.DeleteUser) -> Void) {
        if let user = app.currentUser {
            user.delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success)
                }
            }
        } else {
            let error = NSError(domain: "", code: 1, userInfo: [ NSLocalizedDescriptionKey: "No user is signed in. Can not delete any account."])
            completion(.failure(error))
        }
    }
}
