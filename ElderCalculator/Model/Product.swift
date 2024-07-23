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
    var imageName: String
    
    
    init(name: String, price: Double, quantity: Int, discount: Int, totalPrice: Double, imageName: String) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.discount = discount
        self.totalPrice = totalPrice
        self.imageName = imageName
    }
    
}


struct ProductInfo: Identifiable, Comparable {
    static func < (lhs: ProductInfo, rhs: ProductInfo) -> Bool {
        return rhs.name < lhs.name
    }
    
    let id: UUID = UUID()
    let name: String
    let imageName: String
}

struct ProductInfoData {
    
    static let productsInfo = [
        ProductInfo(
            name: NSLocalizedString("Apple", comment: "productName"),
            imageName: "apple"),
        
        ProductInfo(
            name: NSLocalizedString("Avocado", comment: "productName"),
            imageName: "avocado"),
        
        ProductInfo(
            name: NSLocalizedString("Banana", comment: "productName"),
            imageName: "banana"),
        
        ProductInfo(
            name: NSLocalizedString("Basil", comment: "productName"),
            imageName: "basil"),
        
        ProductInfo(
            name: NSLocalizedString("Battery", comment: "productName"),
            imageName: "battery"),
        
        ProductInfo(
            name: NSLocalizedString("Beef", comment: "productName"),
            imageName: "meat"),
        
        ProductInfo(
            name: NSLocalizedString("Beer", comment: "productName"),
            imageName: "beer"),
        
        ProductInfo(
            name: NSLocalizedString("Beverage", comment: "productName"),
            imageName: "teacup"),
        
        ProductInfo(
            name: NSLocalizedString("Blueberry", comment: "productName"),
            imageName: "blueberries"),
        
        ProductInfo(
            name: NSLocalizedString("Bread", comment: "productName"),
            imageName: "bread"),
        
        ProductInfo(
            name: NSLocalizedString("Broccoli", comment: "productName"),
            imageName: "broccoli"),
        
        ProductInfo(
            name: NSLocalizedString("Butter", comment: "productName"),
            imageName: "butter"),
        
        ProductInfo(
            name: NSLocalizedString("Cabbage", comment: "productName"),
            imageName: "cabbage"),
        
        ProductInfo(
            name: NSLocalizedString("Candy", comment: "productName"),
            imageName: "candy"),
        
        ProductInfo(
            name: NSLocalizedString("Carrot", comment: "productName"),
            imageName: "carrot"),
        
        ProductInfo(
            name: NSLocalizedString("Cheese", comment: "productName"),
            imageName: "cheese"),
        
        ProductInfo(
            name: NSLocalizedString("Chicken", comment: "productName"),
            imageName: "chicken"),
        
        ProductInfo(
            name: NSLocalizedString("Chocolate", comment: "productName"),
            imageName: "chocolate"),
        
        ProductInfo(
            name: NSLocalizedString("Coke", comment: "productName"),
            imageName: "coke"),
        
        ProductInfo(
            name: NSLocalizedString("Coconut", comment: "productName"),
            imageName: "coconut"),
        
        ProductInfo(
            name: NSLocalizedString("Coffee", comment: "productName"),
            imageName: "coffee"),
        
        ProductInfo(
            name: NSLocalizedString("Cookie", comment: "productName"),
            imageName: "cookie"),
        
        ProductInfo(
            name: NSLocalizedString("Corn", comment: "productName"),
            imageName: "corn"),
        
        ProductInfo(
            name: NSLocalizedString("Crab", comment: "productName"),
            imageName: "crab"),
        
        ProductInfo(
            name: NSLocalizedString("Crackers", comment: "productName"),
            imageName: "crackers"),
        
        ProductInfo(
            name: NSLocalizedString("Cucumber", comment: "productName"),
            imageName: "cucumber"),
        
        ProductInfo(
            name: NSLocalizedString("Diaper", comment: "productName"),
            imageName: "diaper"),
        
        ProductInfo(
            name: NSLocalizedString("Donut", comment: "productName"),
            imageName: "doughnut"),
        
        ProductInfo(
            name: NSLocalizedString("Dumpling", comment: "productName"),
            imageName: "dumpling"),
        
        ProductInfo(
            name: NSLocalizedString("Egg", comment: "productName"),
            imageName: "egg"),
        
        ProductInfo(
            name: NSLocalizedString("Fish", comment: "productName"),
            imageName: "fish"),
        
        ProductInfo(
            name: NSLocalizedString("Garlic", comment: "productName"),
            imageName: "garlic"),
        
        ProductInfo(
            name: NSLocalizedString("Ginger", comment: "productName"),
            imageName: "ginger"),
        
        ProductInfo(
            name: NSLocalizedString("Grape", comment: "productName"),
            imageName: "grapes"),
        
        ProductInfo(
            name: NSLocalizedString("Hamburger", comment: "productName"),
            imageName: "hamburger"),
        
        ProductInfo(
            name: NSLocalizedString("Honey", comment: "productName"),
            imageName: "honey"),
        
        ProductInfo(
            name: NSLocalizedString("Hot Dog", comment: "productName"),
            imageName: "hotdog"),
        
        ProductInfo(
            name: NSLocalizedString("Ice Cream", comment: "productName"),
            imageName: "icecream"),
        
        ProductInfo(
            name: NSLocalizedString("Jam", comment: "productName"),
            imageName: "jam"),
        
        ProductInfo(
            name: NSLocalizedString("Juice", comment: "productName"),
            imageName: "juice"),
        
        ProductInfo(
            name: NSLocalizedString("Kiwi", comment: "productName"),
            imageName: "kiwi"),
        
        ProductInfo(
            name: NSLocalizedString("Shrimp", comment: "productName"),
            imageName: "shrimp")
        
    ]
    
}
