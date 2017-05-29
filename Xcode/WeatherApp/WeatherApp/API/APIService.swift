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
    case failed(Error)
}

typealias ForecastResult = (_ resultStatus: ForecastResultStatus) -> ()

protocol APIService {
    
    func fetchForecast(result: ForecastResult)
}

class DefaultAPIService: APIService {

    func fetchForecast(result: ForecastResult) {
        
    }
}
