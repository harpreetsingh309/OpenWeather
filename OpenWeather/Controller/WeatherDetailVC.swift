//
//  WeatherDetailVC.swift
//  OpenWeather
//
//  Created by macexpert on 13/04/21.
//

import UIKit

class WeatherDetailVC: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!

    var weather: WeatherViewModel!
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        headerLabel.text = "Weather for " + weather.cityName
        temperatureLabel.text = weather.temperatureString
        humidityLabel.text = weather.humidityString
        minLabel.text = weather.tempMinString
        maxLabel.text = weather.tempMaxString
        conditionImageView.image = UIImage(systemName: weather.conditionName)
        cityLabel.text = weather.cityName
    }
    
    @IBAction func actionDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

