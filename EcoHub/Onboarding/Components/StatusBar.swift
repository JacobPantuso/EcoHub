//
//  StatusBar.swift
//  EcoHub
//
//  Created by Jacob Pantuso on 2024-02-19.
//

import SwiftUI

struct StatusBar: View {
    @Binding var status: Int
    var body: some View {
        HStack {
            Image("Logo")
                .resizable()
                .frame(width:50, height:50)
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            Text("EcoHub")
                .padding(.leading, 5)
                .font(.title3).bold()
            Spacer()
            Text("Step \(status) of 3")
        }
    }
}
