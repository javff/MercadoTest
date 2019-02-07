//
//  BanksView.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import UIKit
import Siesta.SiestaUI

public class BanksView: UIViewController {
    
    //MARK: - UI Vars
    var tableView: UITableView!
    lazy var statusOverlay:ResourceStatusOverlay = {
        let overlay = ResourceStatusOverlay()
        overlay.errorHeadline?.text = "No se han podido cargar los datos."
        overlay.retryButton.setTitle("Reintentar", for: .normal)
        return overlay
    }()
    
    //MARK: - Vars
    let reuseIdentifier = "BankCell"
    
    //MARK: - Life cycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupCell()
        
        self.tableView.delegate = self
    }
    
    
    //MARK: - Setups
    private func setupView(){
        
        // add tableView //
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
        
        // create background message //
        let label = UILabel(frame: CGRect(origin: view.center, size: CGSize(width: UIScreen.main.bounds.width - 20, height: 300)))
        label.text = "No hay bancos disponible para el método de pago seleccionado."
        label.numberOfLines = 0
        label.textAlignment = .center
        tableView.backgroundView = label
        tableView.backgroundView?.isHidden = true
        
        // disable footer view //
        tableView.tableFooterView = UIView()
        
        // set title //
        navigationItem.title = "Seleccione un banco"
        
        // set backButton //
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setupCell(){
        
        tableView.register(BankCell.self,
                           forCellReuseIdentifier: reuseIdentifier)
    }
    
    
    //MARK: - Helpers
    
    func createCell(tableView:UITableView, indexPath: IndexPath) -> BankCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)! as! BankCell
        
        return cell
    }
    
    func configureCell(cell:BankCell,bank:BankModel){
        
        cell.cellLabel.text = bank.name
        
        if let url = URL(string:bank.secureThumbnail){
            cell.holderImageView.sd_setImage(with: url)
        }
    }
    
   
}

//MARK: - Implement tableView delegate for customize Cells

extension BanksView: UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
