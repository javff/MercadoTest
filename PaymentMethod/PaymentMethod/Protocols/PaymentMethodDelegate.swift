//
//  PaymentMethodDelegate.swift
//  PaymentMethodUI
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation

public protocol PaymentMethodsDelegate:class{
    
    /** this method is called when a payment method is selected
     - Parameters:
     -viewController: The PaymentMethodVC Object
     -method: selected paymentMethod
     -amount: amount selected
     */

    func selectedPaymentMethodFor(_ viewController:PaymentMethodVC,
                                  selected method: PaymentMethodModel,
                                  with amount:Double)
}
