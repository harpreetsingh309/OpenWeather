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

    var weather: WeatherViewModel?
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        guard let model = weather else { return }
        headerLabel.text = "Weather for " + model.cityName
        temperatureLabel.text = model.temperatureString
        humidityLabel.text = model.humidityString
        minLabel.text = model.tempMinString
        maxLabel.text = model.tempMaxString
        conditionImageView.image = UIImage(systemName: model.conditionName)
        cityLabel.text = model.cityName
    }
    
    @IBAction func actionDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

