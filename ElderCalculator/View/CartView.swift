//
//  CartView.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import SwiftUI
import SwiftData

struct CartView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip
    @State private var isAddNewProductPresented: Bool = false
    
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
        }
        .sheet(isPresented: $isAddNewProductPresented, content: {
            AddNewProductView()
        })
   
    }
}

#Preview {
    CartView(trip: 
                Trip(date: Date(),
                     storeName: "Test Store",
                     storeType: "Grocery",
                     budget: 100, tax: 10,
                     storeDiscount: 5))
        .modelContainer(for: [Trip.self], inMemory: true)
}

