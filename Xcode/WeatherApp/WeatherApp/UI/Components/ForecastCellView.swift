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
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
}

extension ForecastCellView: UICollectionViewDataSource {

    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let result = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastDetailsCell", for: indexPath)
        
        if let forecastCollectionViewCell = result as? ForecastDetailsViewCellCollection {
            
            forecastCollectionViewCell.time.text = "13:00:00"
            forecastCollectionViewCell.weatherDescription.text = "very hot\n and sunny"
            forecastCollectionViewCell.tempHumidity.text = "20C / 80%"
            forecastCollectionViewCell.pressure.text = "666 hPa"
        }
        
        return result
    }
}

extension ForecastCellView: UICollectionViewDelegate {
    
}
