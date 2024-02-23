//
//  NameTab.swift
//  EcoHub
//
//  Created by Jacob Pantuso on 2024-02-19.
//

import SwiftUI
import Combine

struct NameTab: View {
    @AppStorage("name") private var name: String = ""
    
    private var formComplete: Bool {
        return !name.isEmpty
    }
    
    var body: some View {
        VStack {
            StatusBar(status: .constant(1))
            Spacer()
            Text("What is Your Name?")
                .font(.title).bold()
            TextField("Name", text: $name)
                .textFieldStyle(DefaultTextFieldStyle())
                .onReceive(Just(name)) { newName in
                    UserDefaults.standard.set(newName, forKey: "name")
                }
            Spacer()
            HStack {
                Text("The information you provide helps EcoHub give you a more personalized experience.")
                    .font(.subheadline)
                    .frame(width: 290)
                NavigationLink(destination: AgeTab(), label: {
                    Image(systemName: "arrow.right")
                        .padding()
                        .background(formComplete ? .green : .gray)
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                })
                .disabled(!formComplete)
            }
            .multilineTextAlignment(.leading)
        }
        .padding(.trailing).padding(.leading)
        .multilineTextAlignment(.center)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NameTab()
}
