//
//  BanksDelegate.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/5/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation

public protocol BanksDelegate:class{
    
    /** this method is called when a bank is selected
     - Parameters:
     -viewController: The BanksVC Object
     -method: selected paymentMethod
     -amount: amount selected
     -bank: selected Bank
     */
    func selectedBankFor(_ viewController:BanksVC,
                                  selected method: PaymentMethodModel,
                                  with amount:Double,
                                  and bank:BankModel)
}
