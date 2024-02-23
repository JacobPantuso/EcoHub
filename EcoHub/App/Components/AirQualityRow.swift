//
//  AirQualityRow.swift
//  EcoHub
//
//  Created by Jacob Pantuso on 2024-02-20.
//

import SwiftUI

struct AirQualityRow: View {
    @StateObject private var aqManager = AQManager()
    @StateObject var locationDataManager = LocationDataManager()
    
    var body: some View {
        VStack {
            if let airQualityData = aqManager.airQualityData {
                VStack {
                    HStack {
                        Image(systemName: "location.fill")
                        Text("AQI in \(locationDataManager.city)")
                            .foregroundStyle(.gray)
                            .font(.system(size: 15).smallCaps())
                    }
                    VStack {
                        Text(String(airQualityData.main.aqi))
                            .font(.title).bold()
                            .foregroundColor(checkAQStatus(value: airQualityData.main.aqi))
                        Text(getAQTranslation(value:airQualityData.main.aqi))
                            .font(.title2).bold()
                    }
                    .padding(5)
                    HStack {
                        ForEach([(name: "PM", sub: "2.5", value: airQualityData.components.pm2_5),
                                 (name: "PM", sub: "10", value: airQualityData.components.pm10),
                                 (name: "NO", sub: "2", value: airQualityData.components.no2)], id: \.sub) { component in
                            VStack {
                                Text(component.name)
                                    .font(.callout).bold()
                                + Text(component.sub)
                                    .font(.system(size: 8.0))
                                    .baselineOffset(-3.5)
                                Text("\(component.value.map { String($0) } ?? "N/A")")
                            }
                            .padding(.leading).padding(.trailing)
                        }
                    }
                    HStack {
                        Text("All air quality metrics are measured in ")
                        + Text("µg/m")
                        + Text("3")
                            .font(.system(size: 8.0))
                            .baselineOffset(6.0)
                    }
                    .font(.system(size: 10))
                    .foregroundStyle(Color.gray)
                    .padding(.bottom)
                }
                .padding(.top)
                .frame(maxWidth: .infinity)
                .background(Color.white
                    .cornerRadius(5)
                    .shadow(radius: 5)
                )
            } else {
                ProgressView()
            }
        }.onAppear {
            aqManager.fetchAirQualityData(for: locationDataManager.latitude, for: locationDataManager.longitude)
        }
    }
    
    func checkAQStatus(value: Int) -> Color {
        switch value {
        case 1:
            return .green
        case 2:
            return .yellow
        case 3:
            return .orange
        case 4:
            return .red
        case 5:
            return .purple
        default:
            return .green
        }
    }
    
    func getAQTranslation(value: Int) -> String {
        switch value {
        case 1:
            return "Excellent"
        case 2:
            return "Fair"
        case 3:
            return "Moderate"
        case 4:
            return "Poor"
        case 5:
            return "Extreme"
        default:
            return "Good"
        }
    }
}
