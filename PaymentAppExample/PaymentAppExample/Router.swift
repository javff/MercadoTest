//
//  Router.swift
//  PaymentApp
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import AmountUI
import PaymentMethod

class Router: NSObject{
    
    //MARK: - Implement Singleton Class
    static let shared: Router = Router()
    private override init(){}
    
    //MARK: -  Vars
    var rootVC: UINavigationController!
    
    //MARK: - Funcs
    func instanceRootVC() -> UIViewController{
        
        let amountVC = AmountVC.CreateView()
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
        viewController.navigationController?.pushViewController(paymentVC,
                                                                animated: true)
    }
}
