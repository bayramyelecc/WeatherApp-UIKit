//
//  OnBoardVC.swift
//  WeatherApp-UIKit
//
//  Created by Bayram Yeleç on 8.11.2024.
//

import UIKit

class OnBoardVC: UIViewController {

   
    @IBOutlet weak var onboardView: UIView!
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hue: 0.6, saturation: 0.3, brightness: 1, alpha: 1)
        onboardView.layer.cornerRadius = 70
        onboardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        onboardView.clipsToBounds = true
        viewModel.fetchWeather()
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        UserDefaults.standard.set(true, forKey: "isOnBoarding")
        
        let vc = storyboard?.instantiateViewController(identifier: "mainvc")
        vc!.modalPresentationStyle = .fullScreen
        vc!.modalTransitionStyle = .crossDissolve
        present(vc!, animated: true)
    }
    
    
}
