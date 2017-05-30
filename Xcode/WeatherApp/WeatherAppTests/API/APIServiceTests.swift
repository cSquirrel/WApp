//
//  APIServiceTests.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 30/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import XCTest
@testable import WeatherApp

class DefaultAPIServiceConfigTests: XCTestCase {
    
    func testCreateEndpointURL() {
        
        // prepare
        let baseURL = URL(string:"http://bbc.co.uk/api/")!
        let config = DefaultAPIServiceConfig(networkingService: MockNetworkingService(),
                                             networkOperationsExecutor: MockNetworkOperationsExecutor(),
                                             baseURL: baseURL,
                                             apiKey: "dummy_key")
        
        // execute
        let result = config.createEndpointURL(servicePath: "service/path")
        
        // verify
        let components = URLComponents.init(url: result, resolvingAgainstBaseURL: false)
        XCTAssertEqual(components?.host, "bbc.co.uk")
        XCTAssertEqual(components?.scheme, "http")
        XCTAssertEqual(components?.path, "/api/service/path")
        XCTAssertNil(components?.queryItems)
    }
    
    func testCreateEndpointURL_WithQueryParams() {
        
        // prepare
        let baseURL = URL(string:"http://bbc.co.uk/api/")!
        let config = DefaultAPIServiceConfig(networkingService: MockNetworkingService(),
                                             networkOperationsExecutor: MockNetworkOperationsExecutor(),
                                             baseURL: baseURL,
                                             apiKey: "dummy_key")
        
        // execute
        let result = config.createEndpointURL(servicePath: "service/path", queryParams:["key1":"value1",
                                                                                        "key2":"value2"])
        
        // verify
        let components = URLComponents.init(url: result, resolvingAgainstBaseURL: false)
        XCTAssertEqual(components?.host, "bbc.co.uk")
        XCTAssertEqual(components?.scheme, "http")
        XCTAssertEqual(components?.path, "/api/service/path")
        XCTAssertEqual(components?.queryItems?.count, 2)
        
    }
}

class ForecastAPIQueryTests: XCTestCase {
    
    func testQueryByCityName() {
        
        // prepare
        let cityName = "London,UK"
        
        // execute
        let query = ForecastAPIQuery(cityName: cityName)
        
        // verify
        let queryParams = query.queryParams
        XCTAssertEqual(queryParams["q"],"London,UK")
        
    }
    
    func testQueryByCityId() {
        
        // prepare
        let cityId = 192837465
        
        // execute
        let query = ForecastAPIQuery(cityId: cityId)
        
        // verify
        let queryParams = query.queryParams
        XCTAssertEqual(queryParams["id"],"192837465")
    }
}


class DefaultAPIServiceTests: XCTestCase {
    
    var api: DefaultAPIService!
    var networkingService: MockNetworkingService!
    
    override func setUp() {
        super.setUp()
        
        networkingService = MockNetworkingService()
        let e = MockNetworkOperationsExecutor()
        let config = DefaultAPIServiceConfig(networkingService: networkingService,
                                             networkOperationsExecutor: e,
                                             baseURL: URL(string:"http://bbc.co.uk/api")!,
                                             apiKey: "dummy_key")
        api = DefaultAPIService(config)
    }
    
    override func tearDown() {
        super.tearDown()
        api = nil
    }
    
    func testFetchForecast() {
        
        // prepare
        let jsonData = TestUtils.loadJSONData(fileName: "forecast_from_server")!
        networkingService.mockDataToReturn = jsonData
        
        let query = ForecastAPIQuery(cityId: 2643743)
        var returnedLocation:Location? = nil
        let shouldReturnLocation = expectation(description: "Should return forecast")
        let result:DefaultAPIService.FetchForecastResult = {(status: ForecastResultStatus) in
            switch(status) {
            case .success(let location):
                returnedLocation = location
                shouldReturnLocation.fulfill()
            default: break
            }
        }
        
        // execute
        api.fetchForecast(query: query, result: result)
        wait(for: [shouldReturnLocation], timeout: 2)
        
        // verify
        XCTAssertNotNil(returnedLocation)
        XCTAssertEqual(returnedLocation?.forecastByDay.keys.count, 5)
        XCTAssertEqual(returnedLocation?.cityId, 2643743)
        XCTAssertEqual(returnedLocation?.name, "London")
    }
}
