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
        let priceValue = Double(product.price) 
        let quantityValue = Double(product.quantity) 
        let discountValue = Double(product.discount) 
        let discountMultiplier = 1 - (discountValue / 100)
        
        totalPrice = (priceValue * quantityValue * discountMultiplier) + totalTax
    }
    
    private func calculateTotalTax() {
        let priceValue = Double(product.price) 
        let quantityValue = Double(product.quantity) 
        let taxMultiplier = Double(trip.tax) / 100
        totalTax = priceValue * quantityValue * taxMultiplier
    }
    
    private func calculateTotalDiscount() {
        let priceValue = Double(product.price)
        let quantityValue = Double(product.quantity)
        let discountValue = Double(product.discount) / 100
        totalDiscount = priceValue * quantityValue * discountValue
    }
}
