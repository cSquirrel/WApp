//
//  ForecastCellView.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 30/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class ForecastCellView: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    var forecastDetails:[Forecast]!
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return forecastDetails.count
    }
}

extension ForecastCellView: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let result = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastDetailsCell", for: indexPath)
        
        if let forecastCollectionViewCell = result as? ForecastDetailsViewCellCollection {
            
            let forecastDetail = forecastDetails[indexPath.row]
            let time = forecastDetail.dateTime.characters.split(separator: " ").map(String.init).last
            var timeComponents = time?.characters.split(separator: ":").map(String.init)
            timeComponents?.removeLast()
            let timeFormatted = timeComponents?.joined(separator: ":")

            forecastCollectionViewCell.time.text = timeFormatted
            forecastCollectionViewCell.weatherDescription.text = forecastDetail.weatherDescription
            forecastCollectionViewCell.tempHumidity.text = "\(forecastDetail.temp)C / \(forecastDetail.humidity)%"
            forecastCollectionViewCell.pressure.text = "\(forecastDetail.pressure) hPa"
        }
        
        return result
    }
}

extension ForecastCellView: UICollectionViewDelegate {
    
}
