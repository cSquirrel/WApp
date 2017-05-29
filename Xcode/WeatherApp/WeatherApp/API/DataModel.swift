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
    let forecastByDay: [String:[Forecast]]
    
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
    
    enum JsonKey {
        static let city = "city"
        static let cityId = "id"
        static let name = "name"
        static let list = "list"
    }
    
    static func create(fromJson json: [String:Any]) -> Location? {
        
        guard
            let city = json[JsonKey.city] as? [String:Any],
            let cityId = city[JsonKey.cityId] as? Int,
            let name = city[JsonKey.name] as? String else {
                return nil
        }
        
        let forecastByDay: [String:[Forecast]]
        if let forecastList = json[JsonKey.list] as? [[String:Any]] {
            forecastByDay = Forecast.create(fromJsonArray: forecastList)
        } else {
            forecastByDay = [:]
        }
        
        let result = Location(cityId: cityId,
                                      name: name,
                                      forecastByDay: forecastByDay)
        return result
    }
    
    static func create(fromLocationAsJsonData jsonData: Data) -> Location? {
        
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
            let locationAsJsonObject = jsonObject as? [String:Any] else {
                return nil
        }
        
        guard let result = create(fromJson: locationAsJsonObject) else {
            return nil
        }
        
        return result
    }
    
}

extension Forecast {
    
    enum JsonKey {
        static let epoch = "dt"
        static let dateTime = "dt_txt"
        static let weather = "weather" 
        static let weatherTitle = "main"
        static let weatherDescription = "description"
        static let main = "main"
        static let temp = "temp"
        static let pressure = "pressure"
        static let humidity = "humidity"
    }
    
    static func create(fromJsonArray json: [[String:Any]]) -> [String:[Forecast]] {
        
        // iterate over forecast JSON elements, deserialise them and group by the day
        var result:[String:[Forecast]] = [:]
        json.forEach { (jsonDict: [String : Any]) in
            
            guard let forecast = create(fromJson: jsonDict) else {
                return
            }
            
            // Split dateTime string ("2017-05-29 15:00:00") into two parts and keep day part for groupping
            guard let date = forecast.dateTime.characters.split(separator: " ").map(String.init).first else {
                return
            }
            
            var forecastPerDate = result[date] ?? []
            forecastPerDate.append(forecast)
            
            result[date] = forecastPerDate
        }
        
        return result
    }
    
    static func create(fromJson json: [String:Any]) -> Forecast? {
        
        guard
            let epoch = json[JsonKey.epoch] as? Int,
            let dateTime = json[JsonKey.dateTime] as? String,
            let weather = json[JsonKey.weather] as? [[String:Any]],
            weather.count > 0,
            let weatherTitle = weather[0][JsonKey.weatherTitle] as? String,
            let weatherDescription = weather[0][JsonKey.weatherDescription] as? String,
            let main = json[JsonKey.main] as? [String:Any],
            let temp = main[JsonKey.temp] as? Float,
            let pressure = main[JsonKey.pressure] as? Float,
            let humidity = main[JsonKey.humidity] as? Int else {
                return nil
        }
        
        let result = Forecast(epoch: epoch,
                              dateTime: dateTime,
                              weatherTitle: weatherTitle,
                              weatherDescription: weatherDescription,
                              temp: temp,
                              pressure: pressure,
                              humidity: humidity)
        return result
    }
}
