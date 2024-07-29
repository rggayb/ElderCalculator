//
//  ProductDetailViewModel.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 16/07/24.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    var product: Product
    var trip: Trip
    
    init(product: Product, trip: Trip) {
        self.product = product
        self.trip = trip
        calculateTotalTax()
        calculateTotalPrice()
        calculateTotalDiscount()
    }
    
    @Published var totalPrice: Double = 0
    @Published var totalTax: Double = 0
    @Published var totalDiscount: Double = 0
    
    private func calculateTotalPrice() {
        let price = Double(product.price)
        let quantity = Double(product.quantity)
        let discountMultiplier = 1 - (Double(product.discount) / 100)
        
        totalPrice = (price * quantity * discountMultiplier) + totalTax
    }
    
    private func calculateTotalTax() {
        let price = Double(product.price)
        let quantity = Double(product.quantity)
        let tax = Double(trip.tax) / 100
        let discountMultiplier = 1 - Double(product.discount) / 100
        
        totalTax = price * quantity * discountMultiplier * tax
    }
    
    private func calculateTotalDiscount() {
        let price = Double(product.price)
        let quantity = Double(product.quantity)
        let discount = Double(product.discount) / 100
        totalDiscount = price * quantity * discount
        
        // Handle 100% discount (free)
        if discount == 1 {
            totalDiscount += totalTax
        }
    }
}
