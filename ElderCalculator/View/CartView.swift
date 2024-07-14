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
    
    
    @State private var productName: String = ""
    @State private var productPrice: String = ""
    @State private var productQuantity: String = ""
    @State private var productDiscount: String = ""
    
    var body: some View {
        List {
            ForEach(trip.products) { product in
                VStack {
                    Text(product.name)
                        .font(.sf(size: 16, weight: .heavy))
                    Text("Rp \(product.price) x \(product.quantity) = \(product.totalPrice)")
                }
            } 
            .onDelete {
                indexes in viewModel.deleteProduct(indexes: indexes, from: trip)
            }
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

