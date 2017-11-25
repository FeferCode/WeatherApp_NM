//
//  WeatherTableViewCell.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 25.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func configureCell(data: City){
        DispatchQueue.main.async {
            self.cityName.text = data.name
            self.cityDescription.text = "\(data.temp)°C " + data.weather_description!
            if let url = data.icon {
                self.weatherImage.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
            }
        }
    }
}
