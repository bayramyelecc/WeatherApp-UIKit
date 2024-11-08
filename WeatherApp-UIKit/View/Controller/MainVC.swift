//
//  MainViewController.swift
//  WeatherApp-UIKit
//
//  Created by Bayram Yeleç on 7.11.2024.
//

import UIKit


class MainVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var switchMode: UISwitch!
    
    var viewModel = MainViewModel()
    var forecastData: [Forecast] = []
    var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hue: 0.6, saturation: 0.3, brightness: 1, alpha: 1)
        switchMode.isOn = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = UIColor.clear
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        viewModel.onWeatherUpdated = { [weak self] weatherResponse in
            self?.updateUI(weather: weatherResponse)
        }
        viewModel.onForecastUpdated = { [weak self] forecast in
            self?.forecastData = forecast
            self?.collectionView.reloadData()
        }
        viewModel.fetchWeather()
        
        
    }
    
    
    func updateUI(weather: Weather){
        self.weather = weather
        cityLabel.text = weather.name
        tempLabel.text = "\(Int(weather.main.temp)) °C"
        customImageView.image = imageForTemperature(weather.main.temp)
    }
    
    
    
    @IBAction func switchTapped(_ sender: Any) {
        guard let weathers = weather else {
            print("Weather verisi bulunamadı")
            return
        }
        
        if switchMode.isOn == false {
            let nightTemp = weathers.main.temp_min
            tempLabel.text = "\(Int(nightTemp))°C"
            print("\(nightTemp) °C")
            view.backgroundColor = .darkGray
        } else {
            let dayTemp = weathers.main.temp
            tempLabel.text = "\(Int(dayTemp))°C"
            print("\(dayTemp) °C")
            view.backgroundColor = UIColor(hue: 0.6, saturation: 0.3, brightness: 1, alpha: 1)
        }
    }

    
    func imageForTemperature(_ temperature: Double) -> UIImage? {
        switch temperature {
        case let temp where temp < 0:
            return UIImage(systemName: "thermometer.snowflake",withConfiguration: UIImage.SymbolConfiguration.preferringMulticolor())
        case 0..<10:
            return UIImage(systemName: "cloud.bolt.rain.fill",withConfiguration: UIImage.SymbolConfiguration.preferringMulticolor())
        case 10..<15:
            return UIImage(systemName: "cloud.rain.fill",withConfiguration: UIImage.SymbolConfiguration.preferringMulticolor())
        case 15..<20:
            return UIImage(systemName: "cloud.fill",withConfiguration: UIImage.SymbolConfiguration.preferringMulticolor())
        case 20..<30:
            return UIImage(systemName: "cloud.sun.fill",withConfiguration: UIImage.SymbolConfiguration.preferringMulticolor())
        case 30..<35:
            return UIImage(systemName: "cloud.sun.fill",withConfiguration: UIImage.SymbolConfiguration.preferringMulticolor())
        default:
            return UIImage(systemName: "sun.max.fill",withConfiguration: UIImage.SymbolConfiguration.preferringMulticolor())
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherCell
        let model = forecastData[indexPath.row]
        cell.items = model
        cell.setup()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 5.7, height: view.frame.width / 4)
    }
    
}


