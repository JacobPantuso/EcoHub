//
//  AgeTab.swift
//  EcoHub
//
//  Created by Jacob Pantuso on 2024-02-19.
//

import SwiftUI
import Combine

struct AgeTab: View {
    @AppStorage("age") private var age: Int?
    @State private var isKeyboardHidden = true
    
    private var formComplete: Bool {
        return age != nil && age! <= 2024
    }
    
    var body: some View {
        VStack {
            StatusBar(status: .constant(2))
            Spacer()
            Text("What year were you born in?")
                .font(.title).bold()
                .frame(width:250)
            TextField("YYYY", text: Binding<String>(
                get: { self.age.map(String.init) ?? "" },
                set: { newValue in
                    // Ensure only numbers are entered
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    
                    // Limit input to 4 characters
                    if filtered.count <= 4, let ageValue = Int(filtered) {
                        self.age = ageValue
                    }
                }
            ))
            .keyboardType(.numberPad)
            .onReceive(Just(age)) { newAge in
                UserDefaults.standard.set(newAge, forKey: "age")
            }
            Spacer()
            HStack {
                Text("The information you provide helps EcoHub give you a more personalized experience.")
                    .font(.subheadline)
                    .frame(width: 290)
                NavigationLink(destination: PermissionsTab(), label: {
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
        .navigationBarBackButtonHidden(true)
        .padding(.trailing).padding(.leading)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    AgeTab()
}
