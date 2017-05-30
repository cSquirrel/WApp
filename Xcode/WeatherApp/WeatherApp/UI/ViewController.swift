//
//  ViewController.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 29/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    
    @IBAction func doRefresh(sender: Any?) {
        
    }
}

// UITableViewDataSource
extension ViewController {
   
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
   
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
        
        if let forecastCellView = result as? ForecastCellView {
            forecastCellView.title.text = "TODAY \(indexPath.row)"
        }
        
        return result
    }
}

// UITableViewDelegate
extension ViewController {
    
}
