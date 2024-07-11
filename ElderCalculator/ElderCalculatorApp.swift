//
//  ElderCalculatorApp.swift
//  ElderCalculator
//
//  Created by Rangga Yudhistira Brata on 08/07/24.
//

import SwiftUI
import SwiftData

@main
struct ElderCalculatorApp: App {
    
//    let container: ModelContainer = {
//        let schema = Schema([Trip.self])
//        let container = try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            ShoppingTripView()
//                .modelContainer(for: [Trip.self, Product.self])
//                .modelContainer(container)
        }
    }
}
