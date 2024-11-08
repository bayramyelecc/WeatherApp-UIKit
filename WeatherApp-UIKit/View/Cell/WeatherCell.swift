//
//  WeatherCell.swift
//  WeatherApp-UIKit
//
//  Created by Bayram Yeleç on 7.11.2024.
//

import UIKit


class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    
    var items: Forecast?
    
    func setup(){
        if #available(iOS 16.0, *) {
            tempLabel.font = .systemFont(ofSize: 12, weight: .black, width: .standard)
        } else {
            
        }
        tempLabel.text = "\(Int(items?.main.temp ?? 0)) °C"
        
        customImageView.image = imageForTemperature(items?.main.temp ?? 0)

        print(items?.weather.first?.description as Any)
        
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.2)
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
    
    
}
