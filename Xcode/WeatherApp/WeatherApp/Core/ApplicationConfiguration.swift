//
//  ApplicationConfiguration.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 30/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class ApplicationConfiguration: NSObject {

    private(set) var apiAccess: DefaultAPIService!
    
    override func awakeFromNib() {
        createApiAccess()
    }
    
    fileprivate func createApiAccess() {
        
        let networkingService = DefaultNetworkingService()
        let networkExecutor = DefaultNetworkOperationsExecutor(configuration: .default)
        // NOTE: data caching service is not fully implemented
        // I added it here only to show how it is used by the API
        let cachingService = DummyDataCachingService()
        
        // These values are hardcoded here but should be provided from an external configuration file
        let baseURL = URL(string:"http://api.openweathermap.org/data/2.5")!
        let apiKey = "8706462a73422ae8125334f257b25e76"
        
        let apiConfig = DefaultAPIServiceConfig(networkingService: networkingService,
                                                networkOperationsExecutor: networkExecutor,
                                           baseURL: baseURL,
                                           apiKey: apiKey,
                                           cachingService: cachingService)
        apiAccess = DefaultAPIService(apiConfig)
    }
    
}
