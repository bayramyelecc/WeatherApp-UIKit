//
//  Weather.swift
//  WeatherApp-UIKit
//
//  Created by Bayram Yeleç on 7.11.2024.
//

import Foundation

struct Weather : Codable {
    let main: Main
    let weather: [Weathers]
    let name: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weathers: Codable {
    let description: String
    let icon: String
}

