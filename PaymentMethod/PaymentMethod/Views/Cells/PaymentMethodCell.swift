//
//  PaymentMethodCell.swift
//  PaymentMethod
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import UIKit

class PaymentMethodCell: UITableViewCell{
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    let holderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(){
        
        self.contentView.addSubview(holderImageView)
        holderImageView.translatesAutoresizingMaskIntoConstraints = false
        holderImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant:10).isActive = true
        holderImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        holderImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        holderImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.contentView.addSubview(cellLabel)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.leadingAnchor.constraint(equalTo: holderImageView.trailingAnchor,constant:10).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant:-10).isActive = true
        cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
