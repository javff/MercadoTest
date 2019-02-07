//
//  PaymentMethodVC.swift
//  PaymentMethodUI
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import UIKit
import Siesta

public class PaymentMethodVC: PaymentMethodsView {
    
    //MARK: - vars
    var paymentMethods:[PaymentMethodModel] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    public weak var delegate:PaymentMethodsDelegate?
    
    let amount:Double
    
    //MARK: Inits
    
    public init(amount:Double){
       self.amount = amount
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupObserverResources()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PaymentMethodServices
            .shared
            .paymentMethodsResource
            .loadIfNeeded()
    }
    
    
    //MARK: - setups
    
    private func setupObserverResources(){
        PaymentMethodServices
            .shared
            .paymentMethodsResource
            .addObserver(self)
            .addObserver(statusOverlay)
    }
    
    private func removeObserverResources(){
        
        PaymentMethodServices
            .shared
            .paymentMethodsResource
            .removeObservers(ownedBy: self)
    }
}


//MARK: - implement Resource Observer Protocol

extension PaymentMethodVC:ResourceObserver{
    
    public func resourceChanged(_ resource: Resource, event: ResourceEvent) {

        self.paymentMethods = resource.typedContent() ?? []
    }
}

//MARK: - Implement TableView DataSource
extension PaymentMethodVC: UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentMethods.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.createCell(tableView: tableView, indexPath: indexPath)
        let currentPaymentMethod = self.paymentMethods[indexPath.row]
        self.configureCell(cell: cell, paymentMethod: currentPaymentMethod)
        return cell
    }
    
    
}

//MARK: - Extend TableView Delegate
extension PaymentMethodVC{
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        let currentPaymentMethod = self.paymentMethods[indexPath.row]
        
        if !currentPaymentMethod.isAllowedAmount(amount: amount){
            self.showAlertInvalidAmount(minAmmount: currentPaymentMethod.minAllowedAmount,
                                        maxAmmount: currentPaymentMethod.maxAllowedAmount)
            return
        }
        
        self.delegate?.selectedPaymentMethodFor(self,
                                                selected: currentPaymentMethod,
                                                with: self.amount)
    }
    
    
}
