//
//  PayerCostModel.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/5/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import Siesta


public struct PayerCostModel: Codable{
    
    public let installments:Double
    public let installmentRate:Double
    public let discuntRate:Double
    public let labels:[String]
    public let installmentRateCollector:[String]
    public let minAllowedAmount:Double
    public let maxAllowedAmount:Double
    public let recommendedMessage:String
    public let installmentAmount:Double?
    public let totalAmount:Double?    
    
    enum CodingKeys: String, CodingKey {
         case installments
         case installmentRate = "installment_rate"
         case discuntRate = "discount_rate"
         case labels
         case installmentRateCollector = "installment_rate_collector"
         case minAllowedAmount = "min_allowed_amount"
         case maxAllowedAmount = "max_allowed_amount"
         case recommendedMessage = "recommended_message"
         case installmentAmount = "installment_amount"
         case totalAmount = "total_amount"
    }
}
