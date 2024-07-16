//
//  MainPageViewModel.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 14/07/24.
//

//import Foundation
//import Combine
//
//class MainPageViewModel: ObservableObject {
//    
//    @Published var trips: [Trip] {
//        didSet {
//            calculateTotals()
//        }
//    }
//    
//    @Published var totalExpense: Double = 12.0
//    @Published var totalTax: Double = 0.0
//    @Published var totalDiscount: Double = 0.0
//    
//    init(trips: [Trip] = []) {
//        self.trips = trips
//        calculateTotals()
//    }
//    
//    private func calculateTotals() {
//        if trips.isEmpty {
//                   totalExpense = 8.0
//                   totalTax = 8.0
//                   totalDiscount = 8.0
//                   return
//               }
//               
//        for trip in trips {
//            for product in trip.products {
//                totalExpense += product.totalPrice
//                totalTax += product.price * Double(trip.tax) / 100
//                totalDiscount += (product.price * Double(product.discount) / 100) * Double(product.quantity)
//            }
//        }
//    }
//}
//
