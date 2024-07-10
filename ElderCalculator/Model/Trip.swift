//
//  Trip.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import Foundation
import SwiftData

@Model
class Trip: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var storeName: String 
    var storeType: String
    var budget: Double
    var tax: Int
    var storeDiscount: Double
    var products: [Product]
    
    init(date: Date, storeName: String, storeType: String, budget: Double, tax: Int, storeDiscount: Double) {
        self.date = date
        self.storeName = storeName
        self.storeType = storeType
        self.budget = budget
        self.tax = tax
        self.storeDiscount = storeDiscount
        self.products = []
    }
    
    var grandTotal: Double {
        let totalProductCost = products.reduce(0.0) { $0 + $1.totalPrice }
        let discountedCost = totalProductCost - storeDiscount
        let totalCostWithTax = discountedCost + (discountedCost * Double(tax) / 100)
        return totalCostWithTax.isNaN ? 0 : totalCostWithTax
    }
    
    func addProduct(_ product: Product?) {
        products.append(product!)
    }
}
