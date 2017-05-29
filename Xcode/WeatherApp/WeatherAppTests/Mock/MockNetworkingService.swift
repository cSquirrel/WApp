//
//  MockNetworkingService.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 30/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit
@testable import WeatherApp

class MockNetworkingService: NetworkingService {

    var mockDataToReturn = Data()
    var lastRequestedURL: URL?
    
    func createGETOperation(url: URL, operationResult: @escaping NetworkOperationResult) -> NetworkOperationBlock {
        return { [unowned self] _ in
            self.lastRequestedURL = url
            operationResult( .successful(self.mockDataToReturn) )
        }
    }
    
}
