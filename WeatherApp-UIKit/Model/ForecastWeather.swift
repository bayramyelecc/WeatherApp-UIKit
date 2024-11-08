//
//  forecastWeather.swift
//  WeatherApp-UIKit
//
//  Created by Bayram Yeleç on 7.11.2024.
//

import Foundation

struct ForecastWeather: Codable {
    let list: [Forecast]
}

struct Forecast: Codable {
    let main: Main2
    let weather: [Weathers2]
    let dt_txt: String
}

struct Main2: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weathers2: Codable {
    let description: String
    let icon: String
}

