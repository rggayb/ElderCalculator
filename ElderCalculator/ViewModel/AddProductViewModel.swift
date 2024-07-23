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
            calculateTotalTax()
            calculateTotalPrice()
            calculateTotalDiscount()
        }
    }
    
    @Published var quantity: String = "1" {
        didSet {
            calculateTotalTax()
            calculateTotalPrice()
            calculateTotalDiscount()
        }
    }
    
    @Published var discount: String = "" {
        didSet {
            calculateTotalTax()
            calculateTotalPrice()
            calculateTotalDiscount()
        }
    }
    
    @Published var totalPrice: Double = 0
    @Published var totalTax: Double = 0
    @Published var totalDiscount: Double = 0
    
    var taxRate: Int = 0
    var qty: Int = 1
    
    private func calculateTotalPrice() {
        let priceValue = Double(price) ?? 0
        let quantityValue = Double(quantity) ?? 1
        let discountValue = Double(discount) ?? 0
        let discountMultiplier = 1 - (discountValue / 100)
        
        totalPrice = (priceValue * quantityValue * discountMultiplier) + totalTax
        
        //to handle 100% discount (free)
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
        
        //to handle 100% discount (free)
        if discountValue == 1 {
            totalDiscount = totalDiscount + totalTax
        }
    }
    
    func isNotExceedBudget(trip: Trip) -> Bool {
            let priceValue = Double(price) ?? 0
            let quantityValue = Double(quantity) ?? 1
            let discountValue = Double(discount) ?? 0
            let discountMultiplier = 1 - (discountValue / 100)
            
            let newProductTotalPrice = (priceValue * quantityValue * discountMultiplier)
            let newTotalExpense = trip.products.reduce(0) { $0 + $1.totalPrice } + newProductTotalPrice
            
            return newTotalExpense <= trip.budget
        }
    
    //validation for add new trip form
    func isProductValid() -> Bool {
        if !price.isEmpty {
            return true
        }
        return false
    }
    
    func resetProductForm() {
        name = ""
        price = ""
        quantity = ""
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
