//
//  ContentView.swift
//  ElderCalculator
//
//  Created by Rangga Yudhistira Brata on 08/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.sf(size: 16, weight: .heavy))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
