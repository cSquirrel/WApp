//
//  APIService.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 29/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

enum ForecastResultStatus {
    
    case success(Location)
    
    case cached(Location)
    
    case failed(Error?)
}

struct ForecastAPIQuery {
    
    public var queryParams: [String:String]
    
    private init(queryParams qp: [String:String]) {
        queryParams = qp
    }
    
    /**
     * Query forecast data by city name, i.e. "London, UK"
     */
    public init(cityName: String) {
        self.init(queryParams: ["q":cityName])
    }
    
    /**
     * Query forecast data by city id, i.e. 2643743
     */
    public init(cityId: Int) {
        self.init(queryParams: ["id":String(cityId)])
    }
    
}

struct DefaultAPIServiceConfig {
    
    let networkingService: NetworkingService
    let baseURL: URL
    let apiKey: String
    
    public func createEndpointURL(servicePath: String, queryParams: [String:String]? = nil) -> URL {
        
        var result = URL(string:baseURL.absoluteString)!
        result.appendPathComponent(servicePath)
        if let query = queryParams {
            // TODO: url encode values
            let queryParamsString = query.map({ return "\($0)=\($1)" }).joined(separator: "&")
            var components = URLComponents(url: result, resolvingAgainstBaseURL: true)!
            components.query = queryParamsString
            result = components.url!
        }
        return result
    }
}

class DefaultAPIService: NSObject {

    enum Const {
        
        static let apiKeyQueryParam = "APPID"
        static let endpointForecast = "forecast"
    }
    
    private let config: DefaultAPIServiceConfig
    
    init(_ c: DefaultAPIServiceConfig) {
        
        config = c
        
    }
    
    typealias FetchForecastResult = (_ resultStatus: ForecastResultStatus) -> ()
    func fetchForecast(query: ForecastAPIQuery, result: @escaping FetchForecastResult) {
        
        // TODO: check cache first
        
        let result = { (status: NetworkOperationStatus) in
            
            switch status {
            case .successful(let data):
                guard let location = Location.create(fromLocationAsJsonData: data) else {
                    result(.failed(nil))
                    return
                }
                // TODO: save 'data' in cache
                result(.success(location))
            case.failed:
                result(.failed(nil))
                return
            }
        }
        
        var queryParams = query.queryParams
        queryParams[Const.apiKeyQueryParam] = config.apiKey
        let endpointURL = config.createEndpointURL(servicePath: Const.endpointForecast, queryParams: queryParams)
        let fetchDataOp = config.networkingService.createGETOperation(url: endpointURL, operationResult: result)
        // TODO: execute the network operation
    }
    
}
