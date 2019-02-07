//
//  InstallmentsDelegate.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/5/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation

public protocol InstallmentsDelegate:class{
    
    /** this method is called when a payerCost is selected
     - Parameters:
     -viewController: The BanksVC Object
     -method: selected paymentMethod
     -amount: amount selected
     -bank: selected Bank
     -payerCost: selected payerCost
     */
    func selectedInstallmentFor(_ viewController:InstallmentsVC,
                         selected method: PaymentMethodModel,
                         with amount:Double,
                         with bank:BankModel,
                         and payerCost:PayerCostModel)
}
