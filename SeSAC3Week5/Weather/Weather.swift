//
//  Weather.swift
//  SeSAC3Week5
//
//  Created by 박다혜 on 2023/08/17.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let id: Int
    let coord: Coord
    let clouds: Clouds
    let visibility: Int
    let weather: [Weather]
    let name: String
    let wind: Wind
    let sys: Sys
    let cod: Int
    let main: Main
    let timezone: Int
    let base: String
    let dt: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let seaLevel: Int
    let tempMax, temp, tempMin, feelsLike: Double
    let humidity, pressure, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case seaLevel = "sea_level"
        case tempMax = "temp_max"
        case temp
        case tempMin = "temp_min"
        case feelsLike = "feels_like"
        case humidity, pressure
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunrise, type: Int
    let country: String
    let id, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let main, description, icon: String
    let id: Int
}

// MARK: - Wind
struct Wind: Codable {
    let gust: Double
    let deg: Int
    let speed: Double
}
