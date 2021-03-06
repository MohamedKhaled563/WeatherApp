//
//  ReportPopUpViewController.swift
//  Clima
//
//  Created by Mohamed Khalid on 18/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class ReportPopUpViewController: UIViewController {
    
    var weatherReportManager = WeatherReportManager()
    var searchedLatitide: Double?
    var searchedLongitude: Double?
    
    var dataArray = [
        ["No.", "--", "--"],
    ]
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        weatherReportManager.delegate = self
        
        popupView.layer.cornerRadius = popupView.frame.size.width / 10
        popupView.clipsToBounds = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
                view.addGestureRecognizer(tapRecognizer)
                tapRecognizer.delegate = self
        
        if let latitude = searchedLatitide{
            if let longitude = searchedLongitude{
                weatherReportManager.performRequest(longitude: longitude, latitude: latitude)
            }
        }
        
        
    }
    @objc func tapped(gestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}



extension ReportPopUpViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.view {
            return true
        } else {
            return false
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension ReportPopUpViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForeginTableViewCell", for: indexPath) as? ForeginTableViewCell{
            cell.dayNumberLabel.text = dataArray[indexPath.row][0]
            cell.temperatureLabel.text = dataArray[indexPath.row][1]
            cell.humedityLabel.text = dataArray[indexPath.row][2]
            return cell
        } else {
            return ForeginTableViewCell()
        }
        
    }
    
    
}


// MARK:- WeatherReportManagerDelegate

extension ReportPopUpViewController: WeatherReportManagerDelegate{
    func didUpdateWeatherReport(_ weatherReportManager: WeatherReportManager, weatherReport: WeatherReportData) {
        print("Enterd did updata wearther function")
        dataArray.removeAll()
        for i in 0...7{
            let dayString = "Day \(i + 1)"
            let tempString = String(format: "%.1f", weatherReport.daily[i].temp.day)
            let humString = String(format: "%d", weatherReport.daily[i].humidity)
            dataArray.append([dayString, tempString, humString])
        }
        tableView.reloadData()
    }
    
    
}


