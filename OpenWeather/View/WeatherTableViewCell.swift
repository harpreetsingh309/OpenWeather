//
//  WeatherTableViewCell.swift
//  OpenWeather
//
//  Created by macexpert on 13/04/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!

    func updateCell(with model: Any) {
        selectionStyle = .none
        if let newModel = model as? WeatherViewModel {
            cityLabel.text = newModel.cityName
            descriptionLabel.text = newModel.desc
            temperatureLabel.text = newModel.temperatureString + Constants.degreeCelcius
            conditionImageView.image = UIImage(systemName: newModel.conditionName)
        }
    }
}
