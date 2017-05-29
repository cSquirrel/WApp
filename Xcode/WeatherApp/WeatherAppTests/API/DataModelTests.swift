//
//  DataModelTests.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 29/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import XCTest
@testable import WeatherApp

class LocationTests: XCTestCase {
    
    func testCreateFromJsonData() {
        
        // prepare
        let jsonData = TestUtils.loadJSONDictionary(fileName: "simple_location")!
        
        // execute
        let result = Location.create(fromJson: jsonData)
        
        // verify
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.cityId, 2643743)
        XCTAssertEqual(result!.name, "London")
        XCTAssertEqual(result!.forecastByDay.count, 1)
    }
    
}

class ForecastTests: XCTestCase {
    
    func testCreateFromJsonData() {
        
        // prepare
        let jsonData = TestUtils.loadJSONDictionary(fileName: "simple_forecast")!
        
        // execute
        let result = Forecast.create(fromJson: jsonData)
        
        // verify
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.epoch, 1496070000)
        XCTAssertEqual(result!.dateTime, "2017-05-29 15:00:00")
        XCTAssertEqual(result!.weatherTitle, "Clouds")
        XCTAssertEqual(result!.weatherDescription, "scattered clouds")
        XCTAssertEqual(result!.temp, 21.1)
        XCTAssertEqual(result!.pressure, 1017.18)
        XCTAssertEqual(result!.humidity, 62)
    }

    func testCreateFromJsonArray() {
        // prepare
        let jsonData = TestUtils.loadJSONDictionary(fileName: "simple_location")!
        let jsonArray = jsonData["list"] as! [[String:Any]]
        
        // execute
        let result = Forecast.create(fromJsonArray: jsonArray)
        
        // verify
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 1)
    }
}
