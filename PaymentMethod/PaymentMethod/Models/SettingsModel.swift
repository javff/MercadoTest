//
//  PaymentSettingsModel.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import Siesta

public struct SettingsModel: Codable {
    
    public let cardNumber: CardNumberModel
    public let bin:BinModel
    public let security:SecurityModel?
    
    
    enum CodingKeys: String, CodingKey {
        case cardNumber = "card_number"
        case bin
        case security
    }
}
