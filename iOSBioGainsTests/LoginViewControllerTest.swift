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
        XCTAssertEqual(makeSUT().emailTextField.placeholder, "Email")
    }
    
    func test_viewDidLoad_RendersPasswordTextFieldPlaceholder() {
        XCTAssertEqual(makeSUT().passwordTextField.placeholder, "Password")
    }
    
    func test_viewDidLoad_RendersLoginButtonText() {
        XCTAssertEqual(makeSUT().loginButton.titleLabel?.text, "Login")
    }
    
    func test_viewDidLoad_RendersEmptyTextFields() {
        XCTAssertTrue(((makeSUT().emailTextField.text?.isEmpty) != nil))
        XCTAssertTrue(((makeSUT().passwordTextField.text?.isEmpty) != nil))
    }
    
    // MARK: - Helper
    
    private func makeSUT() -> LoginViewController {
        let sut = LoginViewController(emailPlaceholder: "Email",
                                      passwordPlaceholder: "Password",
                                      loginButtonText: "Login")
        _ = sut.view
        return sut
    }
}
