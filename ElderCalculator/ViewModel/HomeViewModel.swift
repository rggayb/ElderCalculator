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
    
    var trip: Trip
    
    init(trip: Trip) {
        self.trip = trip
        self.items = trip.products.map { product in
            Item(price: product.price, discount: Double(product.discount) / 100.0, quantity: product.quantity, category: product.name)
        }
        calculateTotal()
    }
    
    func addItem() {
        let priceValue = Double(price) ?? 0.0
        let discountValue = (Double(discount) ?? 0.0) / 100.0
        let quantityValue = Int(quantity) ?? 1
        let categoryValue = selectedCategory.isEmpty ? categories.first! : selectedCategory
        let discountedPrice = priceValue - (priceValue * discountValue)
        
        let newItem = Item(price: discountedPrice, discount: discountValue, quantity: quantityValue, category: categoryValue)
        
        items.append(newItem)
        saveItems()
        
        calculateTotal()
    }
    
    func calculateTotal() {
        var totalValue = items.reduce(0.0) { $0 + ($1.price * Double($1.quantity)) }
        
        if isTaxIncluded {
            totalValue += totalValue * taxPercentage
        }
        
        total = totalValue
    }
    
    func updateItemQuantity(item: Item, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity = quantity
            saveItems()
            calculateTotal()
        }
    }
    
    func removeItem(item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            let removedItem = items.remove(at: index)
            total -= (removedItem.price * Double(removedItem.quantity))
            saveItems()
            calculateTotal()
        }
    }
    
    func removeAllItems() {
        items.removeAll()
        saveItems()
        calculateTotal()
    }
    
    private func saveItems() {
        trip.products = items.map { item in
            Product(name: item.category, price: item.price, quantity: item.quantity, discount: Int(item.discount * 100))
        }
    }
}
