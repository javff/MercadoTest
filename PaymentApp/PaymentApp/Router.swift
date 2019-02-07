//
//  Router.swift
//  PaymentApp
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import AmountUI
import PrettyAlertUI
import PaymentMethod


class Router: NSObject{
    
    //MARK: - Implement Singleton Class
    static let shared: Router = Router()
    private override init(){}
    
    //MARK: -  Vars
    var rootVC: UINavigationController!
    
    //MARK: - Funcs
    func instanceRootVC() -> UIViewController{
        
        let amountVC = AmountVC.createView()
        rootVC = UINavigationController(rootViewController: amountVC)
        amountVC.delegate = self
        return rootVC
    }
}

//MARK: - Implement Amount Delegate
extension Router: AmountDelegate{
    
    func nextButtonTappedFor(_ viewController:AmountVC,
                             with amount:Double){
        
        let paymentVC = PaymentMethodVC(amount: amount)
        paymentVC.delegate = self
        viewController.navigationController?.pushViewController(paymentVC,
                                                                animated: true)
    }
}


//MARK: - Implement Payment Method Delegate

extension Router: PaymentMethodsDelegate{
    
    func selectedPaymentMethodFor(_ viewController: PaymentMethodVC,
                                  selected method: PaymentMethodModel,
                                  with amount: Double) {
        
        let banksVC = BanksVC(amount: amount, paymentMethod: method)
        banksVC.delegate = self
        viewController.navigationController?.pushViewController(banksVC,
                                                                animated: true)
    }
}

//MARK: - Implement Banks Delegate

extension Router: BanksDelegate{
    func selectedBankFor(_ viewController: BanksVC,
                         selected method: PaymentMethodModel,
                         with amount: Double,
                         and bank: BankModel) {
        
        let installmentsVC = InstallmentsVC(amount: amount,
                                            paymentMethod: method,
                                            bank: bank)
        installmentsVC.delegate = self
        viewController.navigationController?.pushViewController(installmentsVC,
                                                                animated: true)
    }
}

//MARK: - Implement Installments Delegate

extension Router: InstallmentsDelegate{
    
    func selectedInstallmentFor(_ viewController: InstallmentsVC,
                                selected method: PaymentMethodModel,
                                with amount: Double,
                                with bank: BankModel,
                                and payerCost: PayerCostModel) {
        
        guard let firstController = viewController.navigationController?.viewControllers.first else{
            return
        }
        
        viewController.navigationController?.popToRootViewController(animated: true)
        
        let resultMessage = "Monto Seleccionado: \(amount) \n Método de pago seleccionado: \(method.name)  \n Banco Seleccionado: \(bank.name) \n Plan de cuotas seleccionado: \(payerCost.recommendedMessage)"
        
        let alertVC = PrettyAlertVC.createPrettyAlert(alertText:resultMessage)
        firstController.present(alertVC, animated: true)
    }
}

