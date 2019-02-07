//
//  PaymentMethodView.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import UIKit
import SDWebImage
import Siesta.SiestaUI

public class PaymentMethodsView: UIViewController {
    
    //MARK: - UI Vars
    var tableView: UITableView!
    
    lazy var statusOverlay:ResourceStatusOverlay = {
        let overlay = ResourceStatusOverlay()
        overlay.errorHeadline?.text = "No se han podido cargar los datos."
        overlay.retryButton.setTitle("Reintentar", for: .normal)
        return overlay
    }()
    
    //MARK: - Vars
    let reuseIdentifier = "PaymentMethodCell"

    //MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupCell()
        
        self.tableView.delegate = self
    }
    
    
    //MARK: - Setups
    private func setupView(){
        
        tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // add status overlay //
        view.addSubview(statusOverlay)
        statusOverlay.translatesAutoresizingMaskIntoConstraints = false
        statusOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        statusOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statusOverlay.widthAnchor.constraint(equalToConstant: 200).isActive = true
        statusOverlay.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // disable footer view //
        tableView.tableFooterView = UIView()
        
        // set title //
        navigationItem.title = "Seleccione el método de pago"
        
        // set backButton //
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setupCell(){
        
        tableView.register(PaymentMethodCell.self,
                           forCellReuseIdentifier: reuseIdentifier)
    }
    
    
    //MARK: - Helpers
    
    func createCell(tableView:UITableView, indexPath: IndexPath) -> PaymentMethodCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)! as! PaymentMethodCell
        
        return cell
    }
    
    func configureCell(cell:PaymentMethodCell,
                       paymentMethod:PaymentMethodModel){
        
        cell.cellLabel.text = paymentMethod.name
        
        if let url = URL(string:paymentMethod.secureThumbnail){
            cell.holderImageView.sd_setImage(with: url)
        }
    }
    
    func showAlertInvalidAmount(minAmmount:Double,maxAmmount:Double){
        
        let msg = "Este método de pago solo admite montos entre \(minAmmount) y \(maxAmmount)"
        
        let alert = UIAlertController(title: "Error",
                                      message: msg,
                                      preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "OK",
                                       style: .cancel)
        alert.addAction(doneAction)
        self.present(alert, animated: true)
    }
}

//MARK: - Implement tableView delegate for customize Cells

extension PaymentMethodsView: UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
