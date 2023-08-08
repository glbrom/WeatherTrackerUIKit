//
//  ViewController.swift
//  WeatherTracker
//
//  Created by Macbook on 11.04.2023.
//

import UIKit
import CoreLocation
import Lottie

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImageWeatherView: UIImageView!
    @IBOutlet weak var conditionLottieImageView: LottieAnimationView!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter city name"
            showAlert(message: "Please. Enter city name")
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            
            self.animationView?.removeFromSuperview()
            
            let animationView = LottieAnimationView(name: weather.conditionNameAnimationWeather)
            animationView.frame = CGRect(x: 10, y: 0, width: 150, height: 150)
            animationView.contentMode = .scaleToFill
            animationView.loopMode = .loop
            animationView.play()
            self.conditionLottieImageView.addSubview(animationView)
            
            self.animationView = animationView
            
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageWeatherView.image = weather.conditionNameImageWeather
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.showAlert(message: "Please. Enter correct city name")
        }
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
