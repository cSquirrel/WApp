//
//  DataCachingService.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 30/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

protocol DataCachingService {
    
    func store(data: Data, key: String)
    
    func fetch(forKey: String) -> Data?
}

// NOTE: data caching service is not fully implemented
// I added it here only to show how it is used by the API
class DummyDataCachingService: DataCachingService {
    
    func store(data: Data, key: String) {
        // TODO: implementation
    }
    
    func fetch(forKey: String) -> Data? {
        // TODO: implementation
        return nil
    }

}
