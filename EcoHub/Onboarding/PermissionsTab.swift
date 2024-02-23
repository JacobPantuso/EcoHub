//
//  PermissionsTab.swift
//  EcoHub
//
//  Created by Jacob Pantuso on 2024-02-19.
//

import SwiftUI
import UserNotifications
import CoreLocation

struct PermissionsTab: View {
    @State private var notifsAllowed: Bool = true
    let locationManager = CLLocationManager()
    private var formComplete: Bool {
        return locationManager.authorizationStatus == .authorizedWhenInUse && notifsAllowed
    }

    var body: some View {
        VStack {
            StatusBar(status: .constant(3))
            Spacer()
            Image(systemName: "gear")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            Text("Permissions")
                .font(.title).bold()
            Text("EcoHub needs the following permissions in order to provide you with the best experience possible.")
            HStack {
                Image(systemName: "location.fill")
                    .foregroundStyle(.blue)
                Text("Location Access")
                Spacer()
                Button(action: {
                    requestLocationPermission()
                }, label: {
                    Text("\(locationManager.authorizationStatus == .authorizedWhenInUse ? "Authorized" : "Allow")")
                        .padding(5)
                        .background(locationManager.authorizationStatus == .authorizedWhenInUse ? .green : .blue)
                        .foregroundStyle(.white)
                        .cornerRadius(5)
                        .font(.subheadline)
                })
            }
            .frame(maxWidth: 250)
            HStack {
                Image(systemName: "bell.fill")
                    .foregroundStyle(.blue)
                Text("Notifications")
                Spacer()
                Button(action: {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("Notification authorization granted.")
                            notifsAllowed = true
                        } else if let error = error {
                            print("Error requesting notification authorization: \(error.localizedDescription)")
                        }
                    }
                }, label: {
                    Text("\(notifsAllowed ? "Authorized" : "Allow")")
                        .padding(5)
                        .background(notifsAllowed ? .green : .blue)
                        .foregroundStyle(.white)
                        .cornerRadius(5)
                        .font(.subheadline)
                })
            }
            .frame(maxWidth: 250)
            Spacer()
            HStack {
                Text("The information you provide helps EcoHub give you a more personalized experience.")
                    .font(.subheadline)
                    .frame(width: 290)
                NavigationLink(destination: ContentView(), label: {
                    Image(systemName: "arrow.right")
                        .padding()
                        .background(formComplete ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                })
                .disabled(!formComplete)
                .onTapGesture {
                    UserDefaults.standard.setValue(false, forKey: "firstTime")
                    UserDefaults.standard.setValue("hello", forKey: "tset")

                }
            }
            .multilineTextAlignment(.leading)
        }
        .navigationBarBackButtonHidden(true)
        .multilineTextAlignment(.center)
        .padding()
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
}

#Preview {
    PermissionsTab()
}
