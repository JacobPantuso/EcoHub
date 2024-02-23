//
//  ContentView.swift
//  EcoHub
//
//  Created by Jacob Pantuso on 2024-02-18.
//

import SwiftUI

struct ContentView: View {
    @State private var firstTime: Bool = (UserDefaults.standard.value(forKey: "firstTime") as? Bool ?? true)
    
    var body: some View {
        VStack {
            if firstTime {
                WelcomeView()
            } else {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .tag(0)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
