//
//  AmountTextField.swift
//  AmountUI
//
//  Created by Juan  Vasquez on 2/2/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import UIKit

public class AmountTextField: UIView{
    
    //MARK: - UI vars
    private let textField:CustomTextField = {
        let textField = CustomTextField()
        textField.backgroundColor = .white
        textField.textAlignment = .left
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.keyboardType = .numberPad
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.boldSystemFont(ofSize: 13)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    //MARK: - Vars
    
    /** receiver delegate */
    public weak var delegate: AmountTextFieldDelegate?
    
    /** this variable contains the current amount */
    public private(set) var amount:Double = 0.0
    /** this variable contains the current amount with pretty string format */
    public private(set) var prettyAmount:String = ""{
        didSet{
            textField.text = prettyAmount
        }
    }
    
    /**currencySymbol for Locale Formmater, default value: '$' */
    public var currencySymbol:String = "$"
    /**number of decimal places maximum for the amount, default value: 2 */
    public var maxDecimalNumber:Int = 2
    /**number of integer places maximum for the amount, default value: 12 */
    public var maxIntegerNumber:Int = 12
    /**locale for amount, default value: en_US */
    public var localeIdentifier: Locale = Locale(identifier: "en_US")
    /**Character for integer separator, default value: . */
    public var groupSeparator:String = "."
    /**Character for decimal separator, default value: , */
    public var decimalSeparator:String = ","
    
    //MARK: - INITS
    override public init(frame: CGRect) {
        super.init(frame:frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    //MARK: - SETUPS
    
    private func setupView(){
        
        self.backgroundColor = .white
        // add textField to view //
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.setupEvents()
    }
    
    private func setupEvents(){
        
        // add event didChange to textField//
        textField.addTarget(self,
                            action: #selector(self.textFieldDidChange(_:)),
                            for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField:UITextField){
        
        guard let text = textField.text else{
            return
        }

        amount = formatAmount(value: text)
        prettyAmount = formatAmount(value: amount)
        delegate?.amountDidChange(self, with: amount, and: prettyAmount)
    }
    
    //MARK: - Funcs
    
    /** this method set a default value to the amountTextfield object*/
    public func setAmountManually(amount:Double){
        self.amount = amount
        prettyAmount = formatAmount(value: amount)
    }
    
    
    //MARK: - Helpers
    
    private func formatAmount(value:String) -> Double{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = maxDecimalNumber
        formatter.maximumIntegerDigits = maxIntegerNumber
        formatter.locale = localeIdentifier
        formatter.currencyDecimalSeparator = decimalSeparator
        formatter.currencyGroupingSeparator = groupSeparator
        formatter.currencySymbol = currencySymbol
        formatter.allowsFloats = true
        var newString = value.replacingOccurrences(of: decimalSeparator, with: "")
                             .replacingOccurrences(of: currencySymbol, with: "")
                             .replacingOccurrences(of: groupSeparator, with: "")
        
        let overFlow = value.count < maxDecimalNumber + 2
        
        if overFlow{
            let overFlowCount = (maxDecimalNumber + 2) - value.count
            for _ in (0...overFlowCount){
                newString.insert("0", at: newString.startIndex)
            }
        }
        
        if newString.count > maxDecimalNumber + maxIntegerNumber{
            newString.removeLast()
        }

        newString = "\(currencySymbol)\(newString)"
        
        newString.insert(",", at: newString.index(newString.endIndex,
                                                  offsetBy: -maxDecimalNumber))
        
        return formatter.number(from: newString) as? Double ?? 0
    }
    
    private func formatAmount(value:Double) -> String{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = localeIdentifier
        formatter.currencyDecimalSeparator = decimalSeparator
        formatter.currencyGroupingSeparator = groupSeparator
        formatter.maximumIntegerDigits = maxIntegerNumber
        formatter.maximumFractionDigits = maxDecimalNumber
        formatter.currencySymbol = currencySymbol
        let result = formatter.string(from: value as NSNumber)
        return "\(result ?? "")"
    }
}



