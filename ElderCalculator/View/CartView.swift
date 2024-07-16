//
//  CartView.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import SwiftUI
import SwiftData

struct CartView: View {
    @State private var isAddNewProductPresented: Bool = false
    
    @Bindable var trip: Trip
    @ObservedObject var viewModel: ShoppingTripViewModel
    @ObservedObject var cartViewModel: CartViewModel
    
    @State private var selectedProduct: Product?
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                Text("date: \(cartViewModel.trip.date, format: Date.FormatStyle(date: .long, time: .none))")
                Text("Total expense: \(cartViewModel.totalExpense, specifier: "%.2f")")
                Text("Budget left: \(cartViewModel.budgetLeft, specifier: "%.2f")")
                Text("Total tax: \(cartViewModel.totalTripTax, specifier: "%.2f") (\(trip.tax)%)")
                Text("Total save: \(cartViewModel.totalTripDiscount, specifier: "%.2f")")
                
                if cartViewModel.isCartEmpty {
                    EmptyCartView()
                } else {
                    List {
                        ForEach(trip.products) { product in
                            VStack {
                                Text(product.name)
                                    .font(.sf(size: 16, weight: .heavy))
                                Text("\(product.quantity) Qty")
                                Text("Per item: \(product.price, specifier: "%.2f")")
                                Text("Total: \(product.totalPrice, specifier: "%.2f")")
                            }
                            .onTapGesture {
                                selectedProduct = product
                            }
                            .sheet(item: $selectedProduct) { selectedProduct in
                                let productDetailViewModel = ProductDetailViewModel(product: selectedProduct, trip: trip)
                                DetailProduct(trip: trip, product: selectedProduct, productDetailViewModel: productDetailViewModel)
                            }
                        }
                        .onDelete(perform: {
                            indexes in viewModel.deleteProduct(indexes: indexes, from: trip)
                            viewModel.calculateTotals()
                        })
                    }
                    .navigationTitle("Cart")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddNewProductPresented.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Handle settings action
                    }) {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $isAddNewProductPresented, content: {
                AddNewProductView(trip: trip, viewModel: viewModel, cartViewModel: cartViewModel)
            })
        }
    }
}

struct EmptyCartView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Your cart is empty.")
                .font(.title)
                .padding()
            Text("Tap the '+' button to add a new item to your cart.")
                .font(.subheadline)
            Spacer()
        }
    }
}

//#Preview {
//    CartView(trip:
//                Trip(date: Date(),
//                     storeName: "Test Store",
//                     budget: 100,
//                     tax: 10
//                    )
//    )
//        .modelContainer(for: [Trip.self], inMemory: true)
//}

