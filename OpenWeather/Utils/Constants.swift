//
//  Constants.swift
//  OpenWeather
//
//  Created by macexpert on 13/04/21.
//

import Foundation

struct Constants {
    static let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    static let cityWeatherBaseURL = "https://api.openweathermap.org/data/2.5/group?units=metric&id=4163971,2147714,2174003"
    static let degreeCelcius = "°C"
    static let strSearch = "Search"
    static let strDelete = "Delete"
}

struct AlertConstant {
    static let alertMsg = "You can search weather from city name"
    static let alertTextfield = "Enter city name here"
    static let alertOK = "OK"
    static let alertCancel = "Cancel"
    static let alertSearch = "Search"
    static let alertSetting = "App need to access your location, turn on Location Services in your device settings."
    
}

struct Errors {
    static let noInternet = "Your Internet connection appears to be offline."
    static let cantFindLoc = "Can't able to find your location."
    static let cantFindCity = "City not found!!\nPlease try different one"
    static let serverError = "Internal Server error ocurred, try again after some time"
    static let EmptyError = "Please enter city name"
}
