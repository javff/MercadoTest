//
//  BanksVC.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import Siesta

public class BanksVC: BanksView {
    
    //MARK: - vars
    var banks:[BankModel] = []{
        didSet{
            
            self.tableView.backgroundView?.isHidden = !banks.isEmpty
            self.tableView.reloadData()
        }
    }
    
    ///The object that acts as the delegate of the BanksVC.
    public weak var delegate:BanksDelegate?
    
    let amount:Double
    let paymentMethod:PaymentMethodModel
    
    //MARK: Inits
    
    public init(amount:Double,paymentMethod:PaymentMethodModel){
        self.amount = amount
        self.paymentMethod = paymentMethod
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
            .banksResource(paymentMethodId: paymentMethod.id)
            .loadIfNeeded()
    }
    
    //MARK: - setups
    private func setupObserverResources(){
        PaymentMethodServices
            .shared
            .banksResource(paymentMethodId:  paymentMethod.id)
            .addObserver(self)
            .addObserver(self.statusOverlay)
    }
    
    private func removeObserverResources(){
        PaymentMethodServices
            .shared
            .banksResource(paymentMethodId:  paymentMethod.id)
            .removeObservers(ownedBy: self)
    }
}


//MARK: - implement Resource Observer Protocol

extension BanksVC:ResourceObserver{
    
    public func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        self.bindingView(banks: resource.typedContent())
    }
    
    //MARK: binding helper resource
    
    private func bindingView(banks:[BankModel]?){
        if let banks = banks{
            self.banks = banks
        }
    }
}

//MARK: - Implement TableView DataSource
extension BanksVC: UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.createCell(tableView: tableView, indexPath: indexPath)
        let currentBank = banks[indexPath.row]
        self.configureCell(cell: cell, bank: currentBank)
        return cell
    }
    
    
}

//MARK: - Extend TableView Delegate
extension BanksVC{
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        let currentBank = banks[indexPath.row]
        self.delegate?.selectedBankFor(self,
                                       selected: paymentMethod,
                                       with: amount,
                                       and: currentBank)
    }
}
