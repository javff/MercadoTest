//
//  BaseAPI.swift
//  BaseNetwork
//
//  Created by Juan  Vasquez on 2/2/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import Foundation
import Siesta


public class BaseAPI {
    
    //MARK: - implement Singleton class //
    public static let shared = BaseAPI()
    
    //MARK: - Vars
    public let service: Service
    public let configuration: ConfigurationSettings
    
    //MARK: - INIT
    
    private init() {
        
        let configuration = BaseAPI.setConfiguration()
        self.configuration = configuration
        self.service = Service(baseURL: configuration.baseURL,
                               standardTransformers: [.text, .image, .json])
        
        SiestaLog.Category.enabled = [.network,
                                      .pipeline,
                                      .observers]
        
        service.configure("**") {
            $0.pipeline[.parsing].removeTransformers()
            $0.headers["Content-Type"] = "application/json"
            $0.expirationTime = 60 * 60
        }
    }
    
    
    
    //MARK: - helpers methods
    
    private class func setConfiguration() -> ConfigurationSettings{
        
        
        //MARK: - FAKE API CONFIGURATION
        return ConfigurationSettings(baseURL: "https://api.mercadopago.com/v1",
                                     publicKey: "444a9ef5-8a6b-429f-abdf-587639155d88")
        
    }
    

    
}
