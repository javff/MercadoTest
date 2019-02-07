//
//  PaymentMethodModel.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import Siesta


public struct PaymentMethodModel: Codable {
    
    public let id: String
    public let name:String
    public let paymentTypeId:String
    public let status:String
    public let secureThumbnail:String
    public let thumbnail:String
    public let deferredCapture:String
    public let settings:[SettingsModel]
    public let additionalInfoNeeded:[String]
    public let minAllowedAmount:Double
    public let maxAllowedAmount:Double
    public let accreditationTime:Int
    public let processingModes:[String]
    

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case paymentTypeId = "payment_type_id"
        case status = "status"
        case secureThumbnail = "secure_thumbnail"
        case thumbnail
        case deferredCapture = "deferred_capture"
        case settings
        case additionalInfoNeeded = "additional_info_needed"
        case minAllowedAmount = "min_allowed_amount"
        case maxAllowedAmount = "max_allowed_amount"
        case accreditationTime = "accreditation_time"
        case processingModes = "processing_modes"
    }
    
    //MARK: - Funcs
    
    public func isAllowedAmount(amount:Double) -> Bool{
        return amount >= minAllowedAmount &&  amount <= maxAllowedAmount
    }
}
