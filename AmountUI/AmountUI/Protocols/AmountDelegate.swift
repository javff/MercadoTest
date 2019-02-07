//
//  AmountDelegate.swift
//  AmountUI
//
//  Created by Juan  Vasquez on 2/2/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation


public protocol AmountDelegate: class{
    
    /***
     this method is executed when amountTextField did change
     **///
    
    /// Specifies the `MessageStyle` to be used for a `MessageContainerView`.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed by this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default value returned by this method is `MessageStyle.bubble`.
    func amountDidChangeFor(_ viewController: AmountVC,
                            with amount:Double,
                            and formatAmount:String)
    
    /***
     this method is executed when nextButton is tapped
     **///
    func nextButtonTappedFor(_ viewController:AmountVC, with amount:Double)
    
}


public extension AmountDelegate{
    
    func amountDidChangeFor(_ viewController: AmountVC,
                            with amount:Double,
                            and formatAmount:String){}
    
    func nextButtonTappedFor(_ viewController:AmountVC,
                              with amount:Double){}
}
