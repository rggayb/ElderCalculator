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
    }
    
    var totalExpense: Double = 0
    var budgetLeft: Double = 0
    var totalTripTax: Double = 0
    var totalTripDiscount: Double = 0
    
    //Computed property to check if the cart is empty
    var isCartEmpty: Bool {
        return trip.products.isEmpty
    }
    
    //Computed property to count the number of products in cart
    var productCount: Int {
        return trip.products.count
    }
    
    func calculateTotalExpense() {
        totalExpense =  trip.products.reduce(0) { $0 + $1.totalPrice }
    }
    
    func calculateBudgetLeft() {
        budgetLeft = trip.budget - totalExpense
    }
    
    func calculateTotalTripTax() {
        let taxMultiplier: Double = Double(trip.tax) / 100
        totalTripTax = trip.products.reduce(0) { $0 + ($1.price * Double($1.quantity)) } * taxMultiplier
    }
    
    func calculateTotalTripDiscount() {
        totalTripDiscount = trip.products.reduce(0) { $0 +
            ((($1.price * Double($1.discount) / 100) * Double($1.quantity))) }
    }

}
