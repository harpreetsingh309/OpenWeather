//
//  WeatherManagerModel.swift
//  OpenWeather
//
//  Created by macexpert on 13/04/21.
//

import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherViewModel)
    func didUpdateBulkWeather(_ weatherManager: WeatherManager, weather: [WeatherViewModel])
    func didFailWithError(error: String)
}

class WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    var activityView: UIActivityIndicatorView?
    
    // MARK:- Get API Key
    private var getAPIKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
                fatalError("Couldn't find file Info.plist")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key")
            }
            return value
        }
    }
    
    // MARK:- Get weather data from cityName
    func fetchWeather(cityName: String) {
            showActivityIndicator()
            let urlString = "\(Constants.weatherBaseURL)&q=\(cityName)&appid=\(getAPIKey)"
            performRequest(with: urlString)
    }
    
    // MARK:- Get weather data as city id's added in URL
    func fetchBulkWeather() {
        showActivityIndicator()
        let urlString = "\(Constants.cityWeatherBaseURL)&appid=\(getAPIKey)"
        performRequest(with: urlString, isBulk: true)
    }
    
    // MARK:- URLSession Task
    private func performRequest(with urlString: String, isBulk: Bool = false) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {[weak self] (data, response, error) in
                if error != nil {
                    self?.hideActivityIndicator()
                    self?.delegate?.didFailWithError(error: Errors.serverError)
                    return
                }
                if let safeData = data {
                    if isBulk {
                        if let weather = self?.parseBulkJSON(safeData) {
                            self?.hideActivityIndicator()
                            self?.delegate?.didUpdateBulkWeather(self!, weather: weather)
                        }
                    } else {
                        if let weather = self?.parseJSON(safeData) {
                            self?.hideActivityIndicator()
                            self?.delegate?.didUpdateWeather(self!, weather: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherViewModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDataModel.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let desc = decodedData.weather[0].description
            let min = decodedData.main.temp_min
            let max = decodedData.main.temp_max
            let humidity = decodedData.main.humidity
            let weather = WeatherViewModel(conditionId: id, cityName: name, temperature: temp, humidity: humidity, temp_min: min, temp_max: max, desc: desc)
            return weather
            
        } catch {
            hideActivityIndicator()
            delegate?.didFailWithError(error: Errors.cantFindCity)
            return nil
        }
    }
    
    private func parseBulkJSON(_ weatherData: Data) -> [WeatherViewModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherListDataModel.self, from: weatherData)
            var list: [WeatherViewModel] = []
            for model in decodedData.list {
                let id = model.weather[0].id
                let temp = model.main.temp
                let name = model.name
                let desc = model.weather[0].description
                let min = model.main.temp_min
                let max = model.main.temp_max
                let humidity = model.main.humidity
                let weather = WeatherViewModel(conditionId: id, cityName: name, temperature: temp, humidity: humidity , temp_min: min, temp_max: max, desc: desc)
                list.append(weather)
            }
            return list
            
        } catch {
            hideActivityIndicator()
            delegate?.didFailWithError(error: Errors.serverError)
            return nil
        }
    }
    
    // MARK:-  Activity Indicator
    private func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.color = .black
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.activityView!.center = UIApplication.scene.view.center
            UIApplication.scene.view.addSubview(self.activityView!)
            self.activityView!.startAnimating()
        }
    }
    
    private func hideActivityIndicator(){
        if (activityView != nil){
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.activityView?.stopAnimating()
            }
        }
    }
}

