//
//  WeatherListDataModel.swift
//  OpenWeather
//
//  Created by macexpert on 13/04/21.
//

import Foundation

enum Cities: String {
    case melbourne = "4163971"
    case sydney = "2147714"
    case brisbane = "2174003"
}

struct WeatherListDataModel: Codable {
    let list: [WeatherDataModel]
}

struct WeatherDataModel: Codable {
    let name: String
    let main: MainTemperature
    let weather: [WeatherCondition]
}

struct MainTemperature: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

struct WeatherCondition: Codable {
    let description: String
    let id: Int
}
