//
//  Item.swift
//  ElderCalculator
//
//  Created by James Cellars on 10/07/24.
//

import Foundation

final class Item: ObservableObject, Identifiable, Codable {
    var id: UUID = UUID()
    var price: Double
    var discount: Double
    var quantity: Int
    var category: String
    
    init(price: Double, discount: Double, quantity: Int, category: String) {
        self.price = price
        self.discount = discount
        self.quantity = quantity
        self.category = category
    }
    
    //Decoding the id property
    private enum CodingKeys: String, CodingKey {
        case id, price, discount, quantity, category
    }
    
    //Decoding initializer
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        price = try container.decode(Double.self, forKey: .price)
        discount = try container.decode(Double.self, forKey: .discount)
        quantity = try container.decode(Int.self, forKey: .quantity)
        category = try container.decode(String.self, forKey: .category)
    }
    
    //Encoding function
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(price, forKey: .price)
        try container.encode(discount, forKey: .discount)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(category, forKey: .category)
    }
}
