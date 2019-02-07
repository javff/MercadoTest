//
//  AmountUnitTest.swift
//  AmountUnitTest
//
//  Created by Juan  Vasquez on 2/6/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import XCTest
@testable import AmountUI

class AmountUnitTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    
    func testConvertAmountDoubleToPrettyString(){
        let amountTextField = AmountTextField()
        amountTextField.setAmountManually(amount: 400)
        XCTAssertEqual(amountTextField.prettyAmount, "$400,00")
    }
   
    func testChangeCustomCurrencySysmbols(){
        let amountTextField = AmountTextField()
        amountTextField.currencySymbol = "T"
        amountTextField.setAmountManually(amount: 2000.20)
        XCTAssertEqual(amountTextField.prettyAmount, "T2.000,20")
        
    }

}
