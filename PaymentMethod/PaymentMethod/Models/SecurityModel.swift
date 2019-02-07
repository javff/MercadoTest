//
//  SecurityModel.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import Siesta

public struct SecurityModel: Codable{
    
    public let length:Int
    public let cardLocation:String
    public let mode:String
    
    enum CodingKeys: String, CodingKey {
        case length
        case cardLocation = "card_location"
        case mode
    }
    
}
