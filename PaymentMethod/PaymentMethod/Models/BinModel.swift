//
//  BinModel.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation

public struct BinModel: Codable{
    
    public let pattern:String
    public let installmentsPattern:String?
    public let exclusionPattern:String?
    
    enum CodingKeys: String, CodingKey {
        case pattern
        case installmentsPattern = "installments_pattern"
        case exclusionPattern = "exclusion_pattern"
    }
}
