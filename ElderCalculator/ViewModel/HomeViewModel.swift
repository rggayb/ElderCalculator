//
//  HomeViewModel.swift
//  ElderCalculator
//
//  Created by James Cellars on 10/07/24.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var price = ""
    @Published var discount = ""
    @Published var quantity = ""
    @Published var selectedCategory = ""
    @Published var total = 0.0
    @Published var isTaxIncluded = false
    
    let taxPercentage = 0.11
    let categories = ["Fruit", "Vegetable", "Dairy", "Meat"]
    
    func calculateTotal() {
        let priceValue = Double(price) ?? 0.0
        let discountValue = (Double(discount) ?? 0.0) / 100.0
        let quantityValue = Double(quantity) ?? 1.0
        var totalValue = (priceValue - (priceValue * discountValue)) * quantityValue
        
        //Includes tax if toggle is on
        if isTaxIncluded {
            totalValue += totalValue * taxPercentage
        }
        
        total += totalValue
    }
}
