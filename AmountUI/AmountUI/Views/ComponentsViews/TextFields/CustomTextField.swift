//
//  CustomTextField.swift
//  AmountUI
//
//  Created by Juan  Vasquez on 2/6/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField{
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
}
