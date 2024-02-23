//
//  WelcomeView.swift
//  EcoHub
//
//  Created by Jacob Pantuso on 2024-02-18.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("Logo")
                Text("EcoHub")
                    .font(.title)
                    .bold()
                Text("Knowledge for a Greener Tomorrow")
                    .font(.subheadline)
                Spacer()
                NavigationLink(destination:
                    NameTab()
                , label: {
                    Text("Get Started")
                    Image(systemName: "arrow.right")
                })
                    .padding().padding(.leading).padding(.trailing)
                    .background(.green)
                    .cornerRadius(5)
                    .foregroundStyle(.white)
                Link("Curious? Learn More.", destination: URL(string: "https://www.jacobpantuso.ca/ecohub")!)
                    .padding(.top, 5)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WelcomeView()
}
