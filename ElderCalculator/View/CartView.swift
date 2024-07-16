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
    //    @State private var isDetailProductPresented: Bool = false
    
    @Bindable var trip: Trip
    @ObservedObject var viewModel: ShoppingTripViewModel
    @ObservedObject var cartViewModel: CartViewModel
    
    @State private var selectedProduct: Product?
    
    
    var body: some View {
        
        VStack {
            //header
            Text("date: \(cartViewModel.trip.date, format: Date.FormatStyle(date: .long, time: .none))")
            Text("total expense: \(cartViewModel.totalExpense, specifier: "%.2f") ")
            Text("budget left: \(cartViewModel.budgetLeft, specifier: "%.2f")")
            Text("total tax: \(cartViewModel.totalTripTax, specifier: "%.2f")")
            Text("total save: \(cartViewModel.totalTripDiscount, specifier: "%.2f")")
            
            
            List {
                ForEach(trip.products) { product in
                    VStack {
                        Text(product.name)
                            .font(.sf(size: 16, weight: .heavy))
                        Text("\(product.quantity) Qty")
                        Text("per item: \(product.price)")
                        Text("\(product.totalPrice)")
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
                .navigationTitle("Cart")
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isAddNewProductPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem {
                    Button {
                    } label: {
                        Image(systemName: "gear")
                    }
                }
                
            }
            .sheet(isPresented: $isAddNewProductPresented, content: {
                AddNewProductView(trip: trip, viewModel: viewModel)
            })
            
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

