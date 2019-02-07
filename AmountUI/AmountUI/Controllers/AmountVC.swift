//
//  AmountVC.swift
//  AmountUI
//
//  Created by Juan  Vasquez on 2/2/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import UIKit

open class AmountVC: UIViewController{
    
    //MARK: - UI Vars
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var amountTextField: AmountTextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: - Vars
    weak public var delegate: AmountDelegate?

    //MARK: - INITS
    public static func createView() -> AmountVC{
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: "AmountView", bundle: bundle)
        let amountVC = storyboard.instantiateInitialViewController()! as! AmountVC
        return amountVC
    }
    
    //MARK: - LIFE CYCLE
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.amountTextField.delegate = self
    }
    
    //MARK: - SETUPS
    private func setupView(){
        self.navigationItem.title = "Módulo de Pago"
        self.nextButton.layer.cornerRadius = 5
    }

   
    //MARK: - FUNCS

    @IBAction func nextButtonTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        let selectedAmount = amountTextField.amount
        
        if selectedAmount <= 0{
            self.showAlertError()
            return
        }
        
        self.delegate?.nextButtonTappedFor(self, with: selectedAmount)
    }
    
    //MARK: - Helpers
    
    private func showAlertError(){
        let alert = UIAlertController(title: "Error",
                                      message: "Introduzca un monto mayor a cero.",
                                      preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "OK",
                                       style: .cancel)
        alert.addAction(doneAction)
        self.present(alert, animated: true)
    }

}

//MARK: - Implement AmountTextFieldDelegate
extension AmountVC: AmountTextFieldDelegate{
    
   public func amountDidChange(_ amountTextField: AmountTextField,
                               with amount: Double,
                               and formatAmount: String) {
        
        self.delegate?.amountDidChangeFor(self, with: amount, and: formatAmount)
    }
    
}

