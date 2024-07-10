//
//  ElderCalculatorApp.swift
//  ElderCalculator
//
//  Created by Rangga Yudhistira Brata on 08/07/24.
//

import SwiftUI

@main
struct ElderCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            ShoppingTripView()
                .modelContainer(for: [Trip.self])
        }
    }
}
