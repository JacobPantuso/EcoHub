//
//  AQManager.swift
//  EcoHub
//
//  Created by Jacob Pantuso on 2024-02-20.
//

import Foundation

struct Secrets {
    static let openWeatherAPIKey: String = {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let apiKey = dict["openWeatherAPIKey"] as? String else {
            fatalError("Secrets.plist or OpenWeatherAPIKey not found")
        }
        return apiKey
    }()
}

struct AirQualityResponse: Codable {
    let list: [AirQualityData]
}

struct AirQualityData: Codable {
    let main: AirQualityMain
    let components: AirQualityComponents

    struct AirQualityComponents: Codable {
        let no2: Double?
        let pm2_5: Double?
        let pm10: Double?
    }
}

struct AirQualityMain: Codable {
    let aqi: Int
}

class AQManager: ObservableObject {
    @Published var airQualityData: AirQualityData?
    @Published var isLoading = false
    
    func fetchAirQualityData(for latitude: Double, for longitude: Double) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/air_pollution?lat=\(latitude)&lon=\(longitude)&appid=\(Secrets.openWeatherAPIKey)") else {
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(AirQualityResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.airQualityData = decodedData.list.first
                }
            } else {
                print("Failed to decode response")
            }
        }.resume()
    }
}
