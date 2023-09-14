//
//  LoginViewControllerTest.swift
//  iOSBioGainsTests
//
//  Created by Alvin Escobar on 9/12/23.
//

import XCTest
@testable import iOSBioGains

final class LoginViewControllerTest: XCTestCase {

    func test_viewDidLoad_EmailTextFieldPlaceholder() {
        let sut = LoginViewController(emailPlaceholder: "Email", passwordPlaceholder: "")
        
        _ = sut.view
        
        XCTAssertEqual(sut.emailTextField.placeholder, "Email")
    }
    
    func test_viewDidLoad_PasswordTextFieldPlaceholder() {
        let sut = LoginViewController(emailPlaceholder: "Email", passwordPlaceholder: "Password")
        
        _ = sut.view
        
        XCTAssertEqual(sut.passwordTextField.placeholder, "Password")
    }
}
