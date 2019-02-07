//
//  BanksVC.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import Siesta

public class InstallmentsVC: InstallmentsView {
    
    //MARK: - Vars
    var installments:[InstallmentModel] = []{
        didSet{
            self.tableView.backgroundView?.isHidden = !installments.isEmpty
            self.tableView.reloadData()
        }
    }
    
    let amount:Double
    let paymentMethod:PaymentMethodModel
    let bank:BankModel
    
    ///The object that acts as the delegate of the InstallmentsVC.
    public weak var delegate:InstallmentsDelegate?
    
    //MARK: - Inits
    
    public init(amount:Double,paymentMethod:PaymentMethodModel,bank:BankModel){
        self.amount = amount
        self.paymentMethod = paymentMethod
        self.bank = bank
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
            .installmentsResources(paymentMethodId: paymentMethod.id,
                                   amount: amount,
                                   issuerId: bank.id)
            .loadIfNeeded()
        
    }
    
    
    //MARK: - setups
    
    private func setupObserverResources(){
        PaymentMethodServices
            .shared
            .installmentsResources(paymentMethodId: paymentMethod.id,
                                   amount: amount,
                                   issuerId: bank.id)
            .addObserver(self)
            .addObserver(statusOverlay)

    }
    
    private func removeObserverResources(){
        
        PaymentMethodServices
            .shared
            .installmentsResources(paymentMethodId: paymentMethod.id,
                                   amount: amount,
                                   issuerId: bank.id)
            .removeObservers(ownedBy: self)
    }
}


//MARK: - implement Resource Observer Protocol

extension InstallmentsVC:ResourceObserver{
    
    public func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        self.bindingView(installments: resource.typedContent())
    }
    
    //MARK: binding helper resource
    
    private func bindingView(installments:[InstallmentModel]?){
        if let installments = installments{
            self.installments = installments
        }
    }
}

//MARK: - Implement TableView DataSource
extension InstallmentsVC: UITableViewDataSource{
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return installments.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return installments[section].payerCost.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let issuer = installments[section].issuer
        return self.createHeaderView(with: issuer)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.createCell(tableView: tableView, indexPath: indexPath)
        let payerCost = installments[indexPath.section].payerCost[indexPath.row]
        self.configureCell(cell: cell, payerCost:payerCost)
        return cell
    }
    
    
}

//MARK: - Extend TableView Delegate
extension InstallmentsVC{
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)

        let payerCost = installments[indexPath.section].payerCost[indexPath.row]
        self.delegate?.selectedInstallmentFor(self,
                                              selected: paymentMethod,
                                              with: amount,
                                              with: bank,
                                              and: payerCost)
    }
}
