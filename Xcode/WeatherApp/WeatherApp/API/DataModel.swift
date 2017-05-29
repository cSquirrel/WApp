//
//  DataModel.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 29/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import Foundation

struct Location {
    
    let cityId: Int
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
    static func create(fromJson json: [String:Any?]) -> Location? {
    static func create(fromJson json: [String:Any]) -> Location? {
    }
}

extension Forecast {
    
    static func create(fromJson: Data) -> Forecast? {
    static func create(fromJson json: [String:Any?]) -> Forecast? {
    static func create(fromJsonArray json: [[String:Any]]) -> [String:Forecast] {
        return [:]
    }
    
    static func create(fromJson json: [String:Any]) -> Forecast? {
        return nil
    }
}
