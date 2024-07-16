//
//  DetailProduct.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 16/07/24.
//

import SwiftUI

struct DetailProduct: View {
    @Bindable var trip: Trip
    @Bindable var product: Product
    @ObservedObject var productDetailViewModel: ProductDetailViewModel
    
    
    var body: some View {
        Text("total price: \(productDetailViewModel.totalPrice) ")
        Text("name: \(product.name)")
        Text("date: \(trip.date)")
        Text("price: \(product.price) ")
        Text("quantity: \(product.quantity)")
        Text("tax (\(trip.tax) %) : \(productDetailViewModel.totalTax) ")
        Text("saved (\(product.discount) %): \(productDetailViewModel.totalDiscount) ")
    }
}

//#Preview {
//    DetailProduct(trip: <#Trip#>)
//}
