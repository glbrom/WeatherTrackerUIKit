//
//  WeatherModel.swift
//  WeatherTracker
//
//  Created by Macbook on 23.04.2023.
//

import Foundation
import UIKit

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    // lottie animation
    var conditionNameAnimationWeather: String {
        let imageName: String
        
        switch conditionId {
        case 200...232:
            imageName = "animation_storm"
        case 300...321:
            imageName = "animation_drizzle"
        case 500...531:
            imageName = "animation_rain"
        case 600...622:
            imageName = "animation_snow"
        case 701...781:
            imageName = "animation_fog"
        case 800:
            imageName = "animation_sun"
        case 801...804:
            imageName = "animation_cloud"
        default:
            imageName = "nosign"
        }
        
        return imageName
    }
    
    // image assets
    var conditionNameImageWeather: UIImage? {
        let imageName: String
        
        switch conditionId {
        case 200...232:
            imageName = "storm"
        case 300...321:
            imageName = "drizzle"
        case 500...531:
            imageName = "rain"
        case 600...622:
            imageName = "snow"
        case 701...781:
            imageName = "fog"
        case 800:
            imageName = "sunny"
        case 801...804:
            imageName = "cloud"
        default:
            imageName = "choice"
        }
        
        return UIImage(named: imageName)
    }
}
