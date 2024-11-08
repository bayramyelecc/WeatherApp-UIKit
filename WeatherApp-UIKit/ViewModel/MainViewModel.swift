//
//  WeatherViewModel.swift
//  WeatherApp-UIKit
//
//  Created by Bayram Yeleç on 7.11.2024.
//

import Foundation
import CoreLocation

class MainViewModel: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var apiKey = "3f00989d1726fb527f50cf81b140eaa5"
    var onWeatherUpdated: ((Weather) -> Void)?
    var onForecastUpdated: (([Forecast]) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func fetchWeather(){
        locationManager.requestLocation()
    }
    
    func fetchWeatherData(latitude: Double, longitude: Double){
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            do {
                let dataItem = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    self.onWeatherUpdated?(dataItem)
                }
            } catch {
                print("veri hatası: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func fetchForecastData(latitude: Double, longitude: Double) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            do {
                let item = try JSONDecoder().decode(ForecastWeather.self, from: data)
                DispatchQueue.main.async {
                    self.onForecastUpdated?(item.list)
                }
            } catch {
                print("forecast veri gelmedi: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print("Konum: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        fetchForecastData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Konum hatası: \(error.localizedDescription)")
    }
    
}

