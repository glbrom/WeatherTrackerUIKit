//
//  WeatherData.swift
//  WeatherTracker
//
//  Created by Macbook on 23.04.2023.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
