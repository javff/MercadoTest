//
//  AmountTextFieldDelegate.swift
//  AmountUI
//
//  Created by Juan  Vasquez on 2/2/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation


public protocol AmountTextFieldDelegate: class{
    
    func amountDidChange(_ amountTextField: AmountTextField,
                         with amount:Double,
                         and formatAmount:String)
    
}

public extension AmountTextFieldDelegate{
    
    func amountDidChange(_ amountTextField: AmountTextField,
                         with amount:Double,
                         and formatAmount:String){}
}
