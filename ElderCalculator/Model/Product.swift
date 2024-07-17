//
//  Product.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import Foundation
import SwiftData

@Model
class Product: Identifiable {
    var id: UUID = UUID()
    var name: String
    var price: Double
    var quantity: Int
    var discount: Int
    var totalPrice: Double = 0.0
//    @Relationship(inverse: \Trip.products) var trips: [Trip]
    

    init(name: String, price: Double, quantity: Int, discount: Int, totalPrice: Double) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.discount = discount
        self.totalPrice = totalPrice
//        self.trips = trips
    }

//    var totalPrice
//    {
//        return (price - (price * Double(discount)/100)) * Double(quantity) 
//    }
    
    
}
