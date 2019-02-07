//
//  BankModel.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import Siesta

public struct BankModel: Codable{
    
    public let id:String
    public let name:String
    public let secureThumbnail:String
    public let thumbnail:String
    public let processingMode:String
    public let merchantAccountId:String?

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case secureThumbnail = "secure_thumbnail"
        case thumbnail
        case processingMode = "processing_mode"
        case merchantAccountId = "merchant_account_id"
    }
}
