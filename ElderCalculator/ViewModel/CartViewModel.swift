//
//  CartViewModel.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 14/07/24.
//

import Foundation
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var trip: Trip
    
    init(trip: Trip) {
        self.trip = trip
        calculateTotalExpense()
        calculateBudgetLeft()
        calculateTotalTripTax()
        calculateTotalTripDiscount()
        countItemInCart()
    }
    
    var totalExpense: Double = 0
    var budgetLeft: Double = 0
    var totalTripTax: Double = 0
    var totalTripDiscount: Double = 0
    @Published var totalItem: Int = 0
    
    func calculateTotalExpense() {
        
        for product in trip.products {
            totalExpense += product.totalPrice
        }
    }
    
    func calculateBudgetLeft() {
        budgetLeft = trip.budget - totalExpense
    }
    
    func calculateTotalTripTax() {
        let taxMultiplier: Double = Double(trip.tax) / 100

        for product in trip.products {
            let discountMultiplier = 1 - (Double(product.discount) / 100)
            totalTripTax += product.price * Double(product.quantity) * discountMultiplier * taxMultiplier
        }
    }
    
    func calculateTotalTripDiscount() {
        
        for product in trip.products {
            let discountMultiplier: Double = Double(product.discount) / 100
            
            totalTripDiscount += product.price * Double(product.quantity) * discountMultiplier
        }
    }
    
    func isExceedBudget() -> Bool {
        if budgetLeft < 0 { return true}
        return false
    }
    
    func countItemInCart(){
        for _ in trip.products {
            totalItem += 1
        }
    }
    
}
