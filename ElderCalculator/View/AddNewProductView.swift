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
    
    @State var trip: Trip
    
    @ObservedObject var viewModel: ShoppingTripViewModel
    @ObservedObject var cartViewModel: CartViewModel
    
//    @State var name: String = ""
//    @State var price: String = ""
//    @State var quantity: String = ""
//    @State var discount: String = ""
//    @State var total: Double = 0
//    @Query private var products: [Product]
    
    @StateObject var productViewModel = ProductViewModel()
    let categories: [String] = ["Fruit", "Vegetable", "Dairy", "Meat"]
    
    var body: some View {
        
        VStack {
            
            Text("total price:  \(Int(productViewModel.totalPrice))")
            Text("tax: \(Int(productViewModel.totalTax)) (\(trip.tax)%)")
            Text("saved: \(Int(productViewModel.totalDiscount))")
            Text("Budget left: Rp \(NumberFormatter.currencyFormatter.string(from: NSNumber(value: cartViewModel.budgetLeft)) ?? "0")")
            Text("Products in cart: \(cartViewModel.productCount)")
            
            Form {
                Section{
//                    TextField("product name", text: $productViewModel.name)
                    //
                    HStack {
                        Text("Name:")
                            .font(.headline)
                        Spacer()
                        Picker("Select Product", selection: $productViewModel.name) {
                            ForEach(categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    }
                    .padding()
                    
                    TextField("price", text: $productViewModel.price)
                        .keyboardType(.numberPad)
                    TextField("qty", text: $productViewModel.quantity)
                    TextField("discount (%)", text: $productViewModel.discount)
                }
                
                Button {
                    viewModel.addNewProduct(
                        name: productViewModel.name,
                        price: Double(productViewModel.price) ?? 0,
                        quantity: Int(productViewModel.quantity) ?? 0,
                        discount: Int(productViewModel.discount) ?? 0, totalPrice: productViewModel.totalPrice,
                        trip: trip)
                    
                    viewModel.calculateTotals()
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
            .onAppear {
                productViewModel.taxRate = trip.tax
            }
        }
        
    }
    
//    private func addNewProduct() {
//        let newProduct = Product(
//            name: name,
//            price: Double(price) ?? 0,
//            quantity: Int(quantity) ?? 0,
//            discount: Int(discount) ?? 0
//        )
//        modelContext.insert(newProduct)
//        trip.addProduct(newProduct)
//    }
}

//#Preview {
//    AddNewProductView()
//        .modelContainer(for: Trip.self, inMemory: true)
//}
