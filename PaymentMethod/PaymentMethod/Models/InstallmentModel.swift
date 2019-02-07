//
//  InstallmentModel.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/5/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import Siesta

public struct InstallmentModel: Codable{
    
    public let paymentMethodId:String
    public let paymentTypeId:String
    public let issuer:IssuerModel
    public let processingMode:String
    public let payerCost:[PayerCostModel]
    
    
    enum CodingKeys: String, CodingKey {
        case paymentMethodId = "payment_method_id"
        case paymentTypeId = "payment_type_id"
        case issuer
        case processingMode = "processing_mode"
        case payerCost = "payer_costs"
    }
}
