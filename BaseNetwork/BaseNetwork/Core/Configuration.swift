//
//  Configuration.swift
//  BaseNetwork
//
//  Created by Juan  Vasquez on 2/3/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation

public class ConfigurationSettings{
    
    public let baseURL:String
    public let publicKey:String
    
    public init(baseURL: String, publicKey: String){
        self.baseURL = baseURL
        self.publicKey = publicKey
    }
}
