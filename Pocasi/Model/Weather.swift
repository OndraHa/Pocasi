//
//  Weather.swift
//  Pocasi
//
//  Created by Ondřej Hadraba on 11.04.2023.
//
struct WeatherCurrent: Codable{
    let temp: Double
    let feels_like: Double
}

struct WeatherDescription: Codable {
    let main: String
    let icon: String
}

struct WeatherMain: Codable {
    let coord: Coordination
    let main: WeatherCurrent
    let weather: [WeatherDescription]
    
   struct Coordination: Codable{
        let lat: Double
        let lon: Double
    }
    
}

struct WeatherForecast: Codable{
    let list: [WeatherDaily]
    
    struct WeatherDaily: Codable{
        let dt: Int
        let main: WeatherCurrent
        let weather: [WeatherDescription]
    }
        
}


struct Weather: Codable{
    var main: WeatherMain
    var forecast: WeatherForecast
}

