//
//  WeatherManager.swift
//  EcoHub
//
//  Created by Jacob Pantuso on 2024-02-20.
//

import Foundation
import WeatherKit

@MainActor class WeatherKitManager: ObservableObject {
    
    @Published var weather: Weather?
    
    func getWeather(latitude: Double, longitude: Double) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) {
                return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longitude))
            }.value
        } catch {
            print("\(error)")
        }
    }
    
    var symbol: String {
        weather?.currentWeather.symbolName ?? "xmark"
    }
    
    var temp: String {
        let temp =
        weather?.currentWeather.temperature.formatted(.measurement(numberFormatStyle: .number.precision(.fractionLength(0))))
        
        return temp?.description ?? "ERR"
    }
    
    var apparentTemp: String {
        let apparentTemp = weather?.currentWeather.apparentTemperature.formatted(.measurement(numberFormatStyle: .number.precision(.fractionLength(0))))
        
        return apparentTemp?.description ?? "ERR"
    }
    
    var uvIndex: String {
        let uvIndex = weather?.currentWeather.uvIndex.value
        
        return uvIndex?.description ?? "ERR"
    }
    
    var windSpeed: String {
        if let speed = weather?.currentWeather.wind.speed.value {
            let speedInt = Int(speed)
            return speedInt.description
        } else {
            return "ERR"
        }
    }
    
    var windGust: String {
        if let gust = weather?.currentWeather.wind.speed.value {
            let gustInt = Int(gust)
            return gustInt.description
        } else {
            return "ERR"
        }
    }
    
    var windDirection: String {
        let windDirection = weather?.currentWeather.wind.compassDirection
        
        return windDirection?.description ?? "ERR"
    }
    
    var condition: String {
        weather?.currentWeather.condition.description ?? "ERR"
    }

}
