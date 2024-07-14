//
//  AddNewProduct.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import SwiftUI
import SwiftData

struct AddNewProductView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var trip: Trip
    @ObservedObject var viewModel: ShoppingTripViewModel
    
    @State var name: String = ""
    @State var price: String = ""
    @State var quantity: String = ""
    @State var discount: String = ""
    
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
                viewModel.addNewProduct(
                    name: name,
                    price: Double(price) ?? 0,
                    quantity: Int(quantity) ?? 0,
                    discount: Int(discount) ?? 0,
                    trip: trip)
                dismiss()
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
    
}

//#Preview {
//    AddNewProductView()
//        .modelContainer(for: Trip.self, inMemory: true)
//}
