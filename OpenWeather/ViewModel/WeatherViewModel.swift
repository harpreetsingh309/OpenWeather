//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by macexpert on 13/04/21.
//

import Foundation

struct WeatherViewModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
    let desc: String

    var temperatureString: String {
        return temperature.toString()
    }

    var humidityString: String {
        return humidity.toString() + "%"
    }

    var tempMaxString: String {
        return temp_max.toString() + Constants.degreeCelcius
    }

    var tempMinString: String {
        return temp_min.toString() + Constants.degreeCelcius
    }

    var conditionName: String {
        switch conditionId {
        case 200...232, 800:
            return "sun.max"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "snow"
        case 701...781:
            return "wind"
        case 801...804:
            return "cloud.fill"
        default:
            return "sun.max"
        }
    }
    
}

extension Double {
    func toString() -> String {
        return String(format: "%.0f",self)
    }
}
