//
//  PaymentMethodUnitTest.swift
//  PaymentMethodUnitTest
//
//  Created by Juan  Vasquez on 2/6/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import XCTest
@testable import PaymentMethod

class PaymentMethodUnitTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    //MARK: - Helpers func to Test
    
    private func createPaymentObject(with minAmmount: Double, and maxAmmount:Double) -> PaymentMethodModel{
        
        return PaymentMethodModel(id: "1",
                                  name: "test",
                                  paymentTypeId: "id",
                                  status: "status",
                                  secureThumbnail: "https://test.image",
                                  thumbnail: "http://test",
                                  deferredCapture: "asd",
                                  settings: [],
                                  additionalInfoNeeded: [],
                                  minAllowedAmount: minAmmount,
                                  maxAllowedAmount: maxAmmount,
                                  accreditationTime: 10,
                                  processingModes: [])
    }
    
    //MARK: - Tests
    
    func testFailPaymentMethodAllowAmount(){
        
        let testAmount:Double = 1000
        let minAmount:Double = 20000
        let maxAmount:Double = 40000
        
        let paymentMethod = self.createPaymentObject(with: minAmount, and: maxAmount)
        
        let response = paymentMethod.isAllowedAmount(amount: testAmount)
        XCTAssertEqual(response, false)
    }
    
    func testSuccessPaymentMethodAllowAmount(){
        
        let testAmount:Double = 30000
        let minAmount:Double = 20000
        let maxAmount:Double = 40000
        
        let paymentMethod = self.createPaymentObject(with: minAmount, and: maxAmount)
        
        let response = paymentMethod.isAllowedAmount(amount: testAmount)
        XCTAssertEqual(response, true)
    }
    
    
    func testBorderSuccessPaymentMethodAllowAmount(){
        
        let minAmount:Double = 20000
        let maxAmount:Double = 40000
        
        let paymentMethod = self.createPaymentObject(with: minAmount, and: maxAmount)
        
        let response = paymentMethod.isAllowedAmount(amount: minAmount)  && paymentMethod.isAllowedAmount(amount: maxAmount)
        XCTAssertEqual(response, true)
    }
    
    func testBorderFailPaymentMethodAllowAmount(){
        
        let minAmount:Double = 20000
        let maxAmount:Double = 40000
        
        let paymentMethod = self.createPaymentObject(with: minAmount, and: maxAmount)
        
        let response = paymentMethod.isAllowedAmount(amount: minAmount - 1)  || paymentMethod.isAllowedAmount(amount: maxAmount + 1)
        XCTAssertEqual(response, false)
    }
    
    
    
    
}
