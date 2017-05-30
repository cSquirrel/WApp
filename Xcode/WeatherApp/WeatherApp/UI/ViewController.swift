//
//  ViewController.swift
//  WeatherApp
//
//  Created by Marcin Maciukiewicz on 29/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var appConfig: ApplicationConfiguration!
    @IBOutlet weak var refresh: UIBarButtonItem!
    
    fileprivate var selectedLocation: Location? = nil
    fileprivate var sortedForecastsByDay: [String] = []
    fileprivate let spinnerView = LoadingSpinnerView()
    
    override func viewDidLoad() {
        doRefresh(sender: nil)
    }
    
    @IBAction func doRefresh(sender: Any?) {
        
        refresh.isEnabled = false
        spinnerView.show(inView: self.view)
        appConfig.apiAccess.fetchForecast(query: ForecastAPIQuery(cityId: 2643743)) { [weak self] (result: ForecastResultStatus) in
            switch(result) {
                case .success(let location):
                    self?.reloadData(location: location)
                case .cached(let location):
                    self?.reloadData(location: location)
                case .failed(_
                    ):
                    break
            }
            DispatchQueue.main.async {
                self?.refresh.isEnabled = true
                self?.spinnerView.hide()
            }
        }
    }
    
    private func reloadData(location: Location) {
        selectedLocation = location
        
        sortedForecastsByDay = Array(location.forecastByDay.keys).sorted { (left:String, right:String) -> Bool in
            return left < right
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}

// UITableViewDataSource
extension ViewController {
   
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let result = sortedForecastsByDay.count
        return result
    }
   
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let result = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
        
        let key = sortedForecastsByDay[indexPath.row]
        let title: String
        switch(indexPath.row) {
            case 0:
                title = "TODAY"
            case 1:
                title = "TOMORROW"
            default:
                title = key
        }
    
        let forecastDetails = selectedLocation?.forecastByDay[key]
        
        if let forecastCellView = result as? ForecastCellView {
            forecastCellView.title.text = title
            forecastCellView.forecastDetails = forecastDetails
            forecastCellView.backgroundColorShift = (indexPath.row % 2) == 0
            
        }
        
        return result
    }
}

// UITableViewDelegate
extension ViewController {
    
}
