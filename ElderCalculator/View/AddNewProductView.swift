//
//  AddNewProduct.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import SwiftUI
import SwiftData

struct AddNewProductView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var trip: Trip
    
    @State var name: String = ""
    @State var price: String = ""
    @State var quantity: String = ""
    @State var discount: String = ""
    
    @Query private var products: [Product]
    
    var body: some View {
        Form {
            Section{
                TextField("product name", text: $name)
                TextField("price", text: $price)
                    .keyboardType(.numberPad)
                TextField("qty", text: $quantity)
                TextField("discount (%)", text: $discount)
            }
            
            Button {
                addNewProduct()
                dismiss()
                //DEBUG
                for product in products {
                    print("DEBUG: Product inserted: \(product.name), \(product.price), \(product.quantity), \(product.discount), \(product.totalPrice)")
                        }
            } label: {
                 Text("Save")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
    
    private func addNewProduct() {
        let newProduct = Product(
            name: name,
            price: Double(price) ?? 0,
            quantity: Int(quantity) ?? 0,
            discount: Int(discount) ?? 0
        )
        modelContext.insert(newProduct)
        trip.addProduct(newProduct)
    }
}

//#Preview {
//    AddNewProductView()
//        .modelContainer(for: Trip.self, inMemory: true)
//}
