//
//  DefaultNetworkingService.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 29/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class DefaultNetworkingService: NetworkingService {

    func createGETOperation(url: URL, operationResult: @escaping NetworkOperationResult) -> NetworkOperationBlock {
        
        return { (session: URLSession) -> () in }
    }
}
