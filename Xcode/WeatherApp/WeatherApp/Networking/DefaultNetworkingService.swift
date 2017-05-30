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
        
        return { (session: URLSession) in
            
            let dataTask = session.dataTask(with: url, completionHandler: {
                (responseData: Data?, urlResponse: URLResponse?, responseError: Error?) in
                
                guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
                    DispatchQueue.global(qos:.default).async { operationResult( .failed(responseError)) }
                    return
                }
                
                guard let rData = responseData else {
                    DispatchQueue.global(qos:.default).async { operationResult( .failed(responseError)) }
                    return
                }
                
                let resultBlock: () -> ()
                let statusCode = httpUrlResponse.statusCode
                switch statusCode {
                case 200 ... 299:
                    resultBlock = {operationResult( .successful(rData) )}
                default:
                    resultBlock = {operationResult( .failed(responseError) )}
                }
                
                DispatchQueue.global(qos:.default).async( execute: resultBlock )
                
            })
            dataTask.resume()
        }
    }
}
