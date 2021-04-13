//
//  WeatherTableViewCell.swift
//  OpenWeather
//
//  Created by macexpert on 13/04/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTemp: UILabel!

    func updateCell(with model: AnyObject) {
        selectionStyle = .none
        if let newModel = model as? WeatherViewModel {
            lblCity.text = newModel.cityName
            lblDescription.text = newModel.desc
            lblTemp.text = newModel.temperatureString + Constants.degreeCelcius
        }
    }
}
