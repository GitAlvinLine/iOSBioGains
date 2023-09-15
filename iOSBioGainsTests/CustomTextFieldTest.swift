//
//  CustomTextFieldTest.swift
//  iOSBioGainsTests
//
//  Created by Alvin Escobar on 9/14/23.
//

import XCTest
import UIKit

class CustomTextField: UITextField {
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
    }
}

final class CustomTextFieldTest: XCTestCase {
    
    func test_init_withPlaceholder() {
        let sut = CustomTextField(placeholder: "Email")
        
        XCTAssertEqual(sut.placeholder, "Email")
    }
}
