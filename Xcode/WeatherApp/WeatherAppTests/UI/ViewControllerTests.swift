//
//  ViewControllerTests.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 30/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import XCTest
@testable import WeatherApp

class ViewControllerTests: XCTestCase {
    
    func testFormatDateString() {
        
        // prepare
        let dateString = "2017-05-01"
        
        // execute
        let result = ViewController.format(dateString:dateString)
        
        // verify
        XCTAssertEqual(result, "Monday, 1 May")
    }
    
}
