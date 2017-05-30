//
//  NetworkingService.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 29/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

public enum NetworkOperationStatus {
    
    case successful(Data)
    case failed(Error?)
    
}

public typealias NetworkOperationBlock = (_ session: URLSession) -> ()

public typealias NetworkOperationResult = (_ result: NetworkOperationStatus) -> Void

public protocol NetworkingService {
    
    func createGETOperation(url: URL, operationResult: @escaping NetworkOperationResult) -> NetworkOperationBlock
    
}
