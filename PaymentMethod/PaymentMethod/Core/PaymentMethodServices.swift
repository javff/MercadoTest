//
//  PaymentMethodServices.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import BaseNetwork
import Siesta


public class PaymentMethodServices{
    
    //MARK: - Implement singleton class
    public static let shared: PaymentMethodServices = PaymentMethodServices()
    
    //MARK: - resources
    
    ///This object provides access to the API paymentMethod resource
    public let paymentMethodsResource: Resource = {
        return BaseAPI.shared
            .service
            .resource(PaymentMethodRoutes.paymentMethods)
            .withParam("public_key", BaseAPI.shared.configuration.publicKey)
    }()
    
    /**This method return a object that provides access to the API Banks resource
    
     -Parameters:
        -paymentMethodId: id of payment method
    
    */
    public func banksResource(paymentMethodId:String) -> Resource{
        
        return BaseAPI.shared
            .service
            .resource(PaymentMethodRoutes.banks)
            .withParam("public_key", BaseAPI.shared.configuration.publicKey)
            .withParam("payment_method_id", paymentMethodId)
    }
    
    /**This method return a object that provides access to the API Installment resource
     
     -Parameters:
     -paymentMethodId: id of payment method
     -amount: amount of installment request
     -issuerId: id of selected bank
     */
    
    public func installmentsResources(paymentMethodId:String,
                                      amount:Double,
                                      issuerId:String) -> Resource{
        
        return BaseAPI.shared
            .service
            .resource(PaymentMethodRoutes.installments)
            .withParam("public_key", BaseAPI.shared.configuration.publicKey)
            .withParam("payment_method_id", paymentMethodId)
            .withParam("amount","\(amount)")
            .withParam("issuer.id", issuerId)
    }
    
    private init(){
        
        //MARK: create mapping for resources

        let jsonDecoder = JSONDecoder()
        
        BaseAPI
        .shared
        .service
        .configureTransformer(PaymentMethodRoutes.paymentMethods) {
            try jsonDecoder.decode([PaymentMethodModel].self,
                                   from: $0.content)
        }
        
        BaseAPI
        .shared
        .service
        .configureTransformer(PaymentMethodRoutes.banks) {
            try jsonDecoder.decode([BankModel].self,
                                   from: $0.content)
        }
        
        BaseAPI
            .shared
            .service
            .configureTransformer(PaymentMethodRoutes.installments) {
                try jsonDecoder.decode([InstallmentModel].self,
                                       from: $0.content)
        }
    }
    
}
