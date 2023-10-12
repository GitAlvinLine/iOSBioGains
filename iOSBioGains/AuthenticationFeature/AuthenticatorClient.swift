//
//  AuthenticatorClient.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/19/23.
//

import Foundation

struct User {
    let email: String
    let name: String
}

enum AuthenticatorClientResult {
    enum Authenticate {
        case success(User)
        case failure(Error)
    }
    
    enum LogOut {
        case success
        case failure(Error)
    }
    
    enum SignUp {
        case success
        case failure(Error)
    }
    
    enum Reset {
        case success
        case failure(Error)
    }
    
    enum DeleteUser {
        case success
        case failure(Error)
    }
}

protocol AuthenticatorClient {
    func authenticate(with email: String, and password: String, completion: @escaping (Result<User, Error>) -> Void)
    func logOut(completion: @escaping (AuthenticatorClientResult.LogOut) -> Void)
    func signUp(with email: String, and password: String, completion: @escaping (AuthenticatorClientResult.SignUp) -> Void)
    func resetPassword(with email: String, and newPassword: String, completion: @escaping (AuthenticatorClientResult.Reset) -> Void)
    func deleteUser(completion: @escaping (AuthenticatorClientResult.DeleteUser) -> Void)
}
