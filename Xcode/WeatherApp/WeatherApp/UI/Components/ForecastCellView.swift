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
    var backgroundColorShift:Bool = false
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return forecastDetails.count
    }
}

extension ForecastCellView: UICollectionViewDataSource {

    enum Const {
    
        static let darkCellColour = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        static let lightCellColour = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let result = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastDetailsCell", for: indexPath)
        
        if let forecastCollectionViewCell = result as? ForecastDetailsViewCellCollection {
            
            let isDarkCell = backgroundColorShift ? ((indexPath.row % 2) == 0) : ((indexPath.row % 2) != 0)
            forecastCollectionViewCell.backgroundColor = isDarkCell ? Const.lightCellColour:Const.darkCellColour
            
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
