//
//  CustomTextFieldTest.swift
//  iOSBioGainsTests
//
//  Created by Alvin Escobar on 9/14/23.
//

import XCTest
import UIKit
@testable import iOSBioGains

final class CustomTextFieldTest: XCTestCase {
    
    func test_init_withPlaceholder() {
        XCTAssertEqual(makeSUT().placeholder, "Email")
    }
    
    func test_init_setKeyboardType() {
        XCTAssertEqual(makeSUT().keyboardType, .emailAddress)
    }
    
    func test_init_setSecureTextEntry() {
        let sut = makeSUT(isSecureTextEntry: true)
        
        XCTAssertEqual(sut.isSecureTextEntry, true)
        XCTAssertEqual(makeSUT().isSecureTextEntry, false)
    }
    
    func test_init_setBorderConfiguration() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.layer.borderWidth, 2)
        XCTAssertEqual(sut.layer.cornerRadius, 10)
    }
    
    func test_init_setFontConfiguration() {
        let sut = makeSUT()
        let preferredFont = UIFont.preferredFont(forTextStyle: .title3)
        
        XCTAssertEqual(sut.font, preferredFont)
    }
    
    func test_init_setTranslatesAutoresizingMaskConstraintsToFalse() {
        XCTAssertEqual(makeSUT().translatesAutoresizingMaskIntoConstraints, false)
    }
    
    func test_textRect_setInsetPadding() {
        let sut = makeSUT()
        let padding = sut.padding
        let sutRect = sut.bounds.inset(by: padding)
        
        let resultRect = sut.textRect(forBounds: sut.frame)
        
        XCTAssertEqual(sutRect, resultRect)
        
    }
    
    func test_traitCollectionDidChange_setBorderColor() {
        let sut = makeSUT()
        let lightMode = UITraitCollection(userInterfaceStyle: .light)
        let darkMode = UITraitCollection(userInterfaceStyle: .dark)
        
        sut.traitCollectionDidChange(lightMode)
        
        XCTAssertEqual(sut.layer.borderColor, UIColor.black.cgColor)
        
        sut.traitCollectionDidChange(darkMode)
        
        XCTAssertEqual(sut.layer.borderColor, UIColor.white.cgColor)
    }
    
    // MARK: Helper
    
    private func makeSUT(isSecureTextEntry: Bool = false) -> CustomTextField {
        return CustomTextField(placeholder: "Email",
                               keyboardType: .emailAddress,
                               secureTextEntry: isSecureTextEntry)
    }
}
