//
//  MockNetworkOperationsExecutor.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 30/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit
@testable import WeatherApp

class MockNetworkOperationsExecutor: NetworkOperationsExecutor {
    
    func execute(operation: @escaping NetworkOperationBlock) {
        operation(URLSession())
    }
}
