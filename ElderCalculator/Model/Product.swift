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
    var name: String
    var price: Double
    var quantity: Int
    var discount: Int
//    @Relationship(inverse: \Trip.products) var trips: [Trip]

    init(name: String, price: Double, quantity: Int, discount: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.discount = discount
//        self.trips = trips
    }

    var totalPrice: Double {
        return (price - (price * Double(discount)/100)) * Double(quantity)
    }
    
    
}
