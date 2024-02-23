//
//  HomeView.swift
//  EcoHub
//
//  Created by Jacob Pantuso on 2024-02-19.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct HomeView: View {
    @State private var name: String = UserDefaults.standard.string(forKey: "name") ?? "Unknown"
    @StateObject var locationDataManager = LocationDataManager()
    @StateObject var weatherKitManager = WeatherKitManager()
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    VStack {
                        HStack {
                            LogoRow()
                                .foregroundStyle(.white)
                            Spacer()
                            HStack {
                                Image(systemName: weatherKitManager.symbol)
                                Text(weatherKitManager.temp)
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                        }
                        .padding(.top).padding(.leading).padding(.trailing)
                    }
                    .padding(.top)
                    VStack {
                        Text("Hey, \(name)!")
                            .foregroundStyle(.white)
                            .font(.title).bold()
                        Text("It's a great day to save the planet.")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                        HStack(spacing: 15) {
                            Image(systemName: "lightbulb.max.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 27)
                                .foregroundStyle(.yellow)
                            
                            VStack(alignment: .leading, spacing: 5) { // Added spacing to improve readability
                                Text("Daily Fact")
                                    .font(.callout)
                                    .bold()
                                    .lineLimit(nil) // Allow multiline
                                Text("Around 27,000 trees are cut down each day.")
                                    .font(.subheadline)
                                    .lineLimit(nil) // Allow multiline
                            }
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding()
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 250)
                .background(.green)
                VStack {
                    VStack(alignment: .leading) {
                        Text("Air Quality")
                            .font(.title2).bold()
                        HStack {
                            Text("Confused?")
                            NavigationLink(destination: AirQualityInfoView(), label: {
                                Text("Learn More")
                            })
                            .foregroundStyle(.blue)
                        }
                        .font(.subheadline)
                        .opacity(0.5)
                        AirQualityRow()
                    }
                    .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .clipShape(
                    .rect(
                        topLeadingRadius: 20,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 20
                    )
                )
                .ignoresSafeArea()
            }
            .task {
                await weatherKitManager.getWeather(latitude: locationDataManager.latitude, longitude: locationDataManager.longitude)
            }
            .background(.green)
            .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview {
    HomeView()
}
