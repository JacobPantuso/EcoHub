//
//  LogoRow.swift
//  EcoHub
//
//  Created by Jacob Pantuso on 2024-02-19.
//

import SwiftUI

struct LogoRow: View {
    var body: some View {
        HStack {
            Image("Logo")
                .resizable()
                .frame(width:50, height:50)
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            VStack(alignment: .leading) {
                Text("EcoHub")
                    .font(.title3).bold()
                Text("A Cleaner Earth for All.")
                    .font(.system(size:10))
            }
            .padding(.leading, 5)
        }
    }
}
