//
//  ReportPopUpViewController.swift
//  Clima
//
//  Created by Mohamed Khalid on 18/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class ReportPopUpViewController: UIViewController {
    
    var dataArray = [
        ["Day 1", "14.3", "32"],
        ["Day 2", "142.3", "2"],
        ["Day 3", "144.3", "5"],
    ]
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
                
        popupView.layer.cornerRadius = popupView.frame.size.width / 10
        popupView.clipsToBounds = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
                view.addGestureRecognizer(tapRecognizer)
                tapRecognizer.delegate = self
    }
    @objc func tapped(gestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}



extension ReportPopUpViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == tableView{
            return false
        } else {
            return true
        }
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
