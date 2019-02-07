//
//  IssuerModel.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/5/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import Siesta

public struct IssuerModel: Codable{
    
    public let id:String
    public let name:String
    public let secureThumbnail:String
    public let thumbnail:String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case secureThumbnail = "secure_thumbnail"
        case thumbnail
    }
}
