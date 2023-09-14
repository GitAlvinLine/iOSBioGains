//
//  LoginViewControllerTest.swift
//  iOSBioGainsTests
//
//  Created by Alvin Escobar on 9/12/23.
//

import XCTest
@testable import iOSBioGains

final class LoginViewControllerTest: XCTestCase {

    func test_viewDidLoad_RendersEmailTextFieldPlaceholder() {
        let sut = LoginViewController(emailPlaceholder: "Email", passwordPlaceholder: "", loginButtonText: "")
        
        _ = sut.view
        
        XCTAssertEqual(sut.emailTextField.placeholder, "Email")
    }
    
    func test_viewDidLoad_RendersPasswordTextFieldPlaceholder() {
        let sut = LoginViewController(emailPlaceholder: "Email", passwordPlaceholder: "Password", loginButtonText: "")
        
        _ = sut.view
        
        XCTAssertEqual(sut.passwordTextField.placeholder, "Password")
    }
    
    func test_viewDidLoad_RendersLoginButtonText() {
        let sut = LoginViewController(emailPlaceholder: "", passwordPlaceholder: "", loginButtonText: "Login")
        
        _ = sut.view
        
        XCTAssertEqual(sut.loginButton.titleLabel?.text, "Login")
    }
}
