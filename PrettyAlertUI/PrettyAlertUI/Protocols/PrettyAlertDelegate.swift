//
//  PrettyAlertDelegate.swift
//  PrettyAlertUI
//
//  Created by Juan  Vasquez on 2/6/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation

public protocol PrettyAlertDelegate:class{
    
    /** this method is called when doneButton is tapped
     - Parameters:
        -viewController: The PrettyAlertVC Object
     */
    func doneActionButtonTappedFor(viewController:PrettyAlertVC)
}
