//
//  CardNumberModel.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import Siesta

public struct CardNumberModel: Codable{
    
    public let validation:String
    public let length:Int
    
    enum CodingKeys: String, CodingKey {
        case validation
        case length
    }
}
