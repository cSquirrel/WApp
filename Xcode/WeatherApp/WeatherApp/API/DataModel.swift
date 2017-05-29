//
//  DataModel.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 29/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import Foundation

struct Location {
    
    let cityId: String
    let name: String
    let forecastByDay: [String:Forecast]
    
}

struct Forecast {
    
    let epoch: Int
    let dateTime: String
    let weatherTitle: String
    let weatherDescription: String
    let temp: Float
    let pressure: Float
    let humidity: Int

}

extension Location {
    
    static func create(fromJson: Data) -> Location? {
        return nil
    }
}

extension Forecast {
    
    static func create(fromJson: Data) -> Forecast? {
        return nil
    }
}
