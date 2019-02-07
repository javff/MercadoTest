//
//  InstallmentsView.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/5/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import UIKit
import Siesta.SiestaUI

public class InstallmentsView: UIViewController {
    
    //MARK: - UI Vars
    var tableView: UITableView!
    lazy var statusOverlay:ResourceStatusOverlay = {
        let overlay = ResourceStatusOverlay()
        overlay.errorHeadline?.text = "No se han podido cargar los datos."
        overlay.retryButton.setTitle("Reintentar", for: .normal)
        return overlay
    }()
    
    //MARK: - Vars
    let reuseIdentifier = "InstallmentCell"
    
    
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
        
        // create background message //
        let label = UILabel(frame: CGRect(origin: view.center,
                                          size: CGSize(width: UIScreen.main.bounds.width - 20, height: 300)))
        label.text = "No hay plan de cuotas disponible para el banco seleccionado."
        label.numberOfLines = 0
        label.textAlignment = .center
        tableView.backgroundView = label
        tableView.backgroundView?.isHidden = true
        
        // set title //
        navigationItem.title = "Seleccione un plan de cuotas"
        
        // set backButton //
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setupCell(){
        
        tableView.register(InstallmentCell.self,
                           forCellReuseIdentifier: reuseIdentifier)
    }
    
    
    //MARK: - Helpers
    
    func createCell(tableView:UITableView, indexPath: IndexPath) -> InstallmentCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)! as! InstallmentCell
        
        return cell
    }
    
    func configureCell(cell:InstallmentCell,payerCost:PayerCostModel){
        
        cell.cellLabel.text = payerCost.recommendedMessage
    }
    
    func createHeaderView(with issuer:IssuerModel) -> UIView{
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        // create holder image view //
        let holderImageView = UIImageView()
        headerView.addSubview(holderImageView)
        holderImageView.translatesAutoresizingMaskIntoConstraints = false
        holderImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant:10).isActive = true
        holderImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        holderImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        holderImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        //create issuer name label //
        let issuerNameLabel = UILabel()
        headerView.addSubview(issuerNameLabel)
        issuerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        issuerNameLabel.leadingAnchor.constraint(equalTo: holderImageView.trailingAnchor,constant:10).isActive = true
        issuerNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        issuerNameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant:-10).isActive = true
        
        //binding data //
        issuerNameLabel.text = issuer.name
        issuerNameLabel.font = UIFont.systemFont(ofSize: 12)
        if let url = URL(string:issuer.secureThumbnail){
            holderImageView.sd_setImage(with: url)
        }
        
        return headerView
        
    }
}

//MARK: - Implement tableView delegate for customize Cells

extension InstallmentsView: UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
