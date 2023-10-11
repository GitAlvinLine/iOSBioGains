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
                if let email = user.profile.email,
                   let name = user.profile.name {
                    let appUser: User = User(email: email, name: name)
                    completion(.success(appUser))
                } else {
                    completion(.success(User(email: "", name: "")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
