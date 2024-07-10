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
    @Published var items: [Item] = []
    
    let taxPercentage = 0.11
    let categories = ["Fruit", "Vegetable", "Dairy", "Meat"]
    
    func addItem() {
        let priceValue = Double(price) ?? 0.0
        let discountValue = (Double(discount) ?? 0.0) / 100.0
        let quantityValue = Int(quantity) ?? 1
        let categoryValue = selectedCategory.isEmpty ? categories.first! : selectedCategory
        let discountedPrice = priceValue - (priceValue * discountValue)
        
        let newItem = Item(price: discountedPrice, discount: discountValue, quantity: quantityValue, category: categoryValue)
        
        items.append(newItem)
        print("added item")
        calculateTotal()
    }
    
    func calculateTotal() {
        var totalValue = items.reduce(0.0) { $0 + ($1.price * Double($1.quantity)) }
        
        //Includes tax if toggle is on
        if isTaxIncluded {
            totalValue += totalValue * taxPercentage
        }
        
        print("calculated total")
        total += totalValue
    }
    
    func updateItemQuantity(item: Item, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity = quantity
            calculateTotal()
        }
    }
    
    func removeItem(item: Item) {
        items.removeAll { $0.id == item.id }
        calculateTotal()
        print("removed item")
    }
    
    func removeAllItems() {
        items.removeAll()
        calculateTotal()
        print("removed all")
    }
}
