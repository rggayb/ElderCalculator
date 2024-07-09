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
            
            //camera button
            Button {
                
            } label: {
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
