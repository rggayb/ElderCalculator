//
//  AddProductViewModel.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 14/07/24.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var name: String = ""
    
    @Published var price: String = "" {
        didSet {
            calculateTotalPrice()
            calculateTotalTax()
            calculateTotalDiscount()
        }
    }
    
    @Published var quantity: String = "" {
        didSet {
            calculateTotalPrice()
            calculateTotalTax()
            calculateTotalDiscount()
        }
    }
    
    @Published var discount: String = "" {
        didSet {
            calculateTotalPrice()
            calculateTotalTax()
            calculateTotalDiscount()
        }
    }
    
    @Published var totalPrice: Double = 0
    @Published var totalTax: Double = 0
    @Published var totalDiscount: Double = 0
    
    var taxRate: Int = 0
    
    private func calculateTotalPrice() {
        let priceValue = Double(price) ?? 0
        let quantityValue = Double(quantity) ?? 0
        let discountValue = Double(discount) ?? 0
        let discountMultiplier = 1 - (discountValue / 100)
        
        totalPrice = (priceValue * quantityValue * discountMultiplier) + totalTax
    }
    
    private func calculateTotalTax() {
        let priceValue = Double(price) ?? 0
        let quantityValue = Double(quantity) ?? 0
        let taxMultiplier = Double(taxRate) / 100
        totalTax = priceValue * quantityValue * taxMultiplier
    }
    
    private func calculateTotalDiscount() {
        let priceValue = Double(price) ?? 0
        let quantityValue = Double(quantity) ?? 0
        let discountValue = (Double(discount) ?? 0) / 100
        totalDiscount = priceValue * quantityValue * discountValue
    }
}

