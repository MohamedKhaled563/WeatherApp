//
//  ForeginTableViewCell.swift
//  Clima
//
//  Created by Mohamed Khalid on 18/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class ForeginTableViewCell: UITableViewCell {

    @IBOutlet var dayNumberLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humedityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
