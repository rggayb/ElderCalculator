//
//  Item.swift
//  ElderCalculator
//
//  Created by James Cellars on 10/07/24.
//

import Foundation

struct Item: Identifiable {
    let id = UUID()
    var price: Double
    var discount: Double
    var quantity: Int
    var category: String
}
