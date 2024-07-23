//
//  AddProductViewModel.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 14/07/24.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var name: String = NSLocalizedString("Choose item", comment: "productName")
    
    @Published var price: String = "" {
        didSet {
            calculateTotals()
        }
    }
    
    @Published var quantity: String = "1" {
        didSet {
            calculateTotals()
        }
    }
    
    @Published var discount: String = "" {
        didSet {
            calculateTotals()
        }
    }
    
    @Published var totalPrice: Double = 0
    @Published var totalTax: Double = 0
    @Published var totalDiscount: Double = 0
    
    var taxRate: Int = 0
    var qty: Int = 1
    
    // calculate all total
    private func calculateTotals() {
        calculateTotalTax()
        calculateTotalDiscount()
        calculateTotalPrice()
    }

    private func calculateTotalPrice() {
        let priceValue = Double(price) ?? 0
        let quantityValue = Double(quantity) ?? 1
        let discountValue = Double(discount) ?? 0
        let discountMultiplier = 1 - (discountValue / 100)
        
        totalPrice = (priceValue * quantityValue * discountMultiplier) + totalTax
        
        // Handle 100% discount (free)
        if discountMultiplier == 0 {
            totalPrice = 0
        }
    }
    
    private func calculateTotalTax() {
        let priceValue = Double(price) ?? 0
        let quantityValue = Double(quantity) ?? 1
        let taxMultiplier = Double(taxRate) / 100
        let discountValue = Double(discount) ?? 0
        let discountMultiplier = 1 - (discountValue / 100)
        
        totalTax = priceValue * quantityValue * discountMultiplier * taxMultiplier
    }
    
    private func calculateTotalDiscount() {
        let priceValue = Double(price) ?? 0
        let quantityValue = Double(quantity) ?? 1
        let discountValue = (Double(discount) ?? 0) / 100
        totalDiscount = priceValue * quantityValue * discountValue
        
        // Handle 100% discount (free)
        if discountValue == 1 {
            totalDiscount += totalTax
        }
    }
    
    func isNotExceedBudget(trip: Trip) -> Bool {
        let priceValue = Double(price) ?? 0
        let quantityValue = Double(quantity) ?? 1
        let discountValue = Double(discount) ?? 0
        let discountMultiplier = 1 - (discountValue / 100)
        
        let newProductTotalPrice = priceValue * quantityValue * discountMultiplier
        let newTotalExpense = trip.products.reduce(0) { $0 + $1.totalPrice } + newProductTotalPrice
        
        return newTotalExpense <= trip.budget
    }
    
    // validation for add new trip form
    func isProductValid() -> Bool {
        return !price.isEmpty
    }
    
    func resetProductForm() {
        name = NSLocalizedString("Choose item", comment: "productName")
        price = ""
        quantity = "1"
        discount = ""
    }
    
    func checkSelectedCategory() {
        if name == NSLocalizedString("Choose item", comment: "productName") {
            name = NSLocalizedString("Product", comment: "productName")
        }
    }
    
    func addQuantity() {
            qty += 1
            quantity = String(qty)
            
        }
        
        func subtractQuantity() {
            qty -= 1
            
            if qty <= 0 {
                qty = 1
            }
            
            quantity = String(qty)
        }
}
