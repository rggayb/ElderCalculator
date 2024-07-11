//
//  CartView.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import SwiftUI
import SwiftData

struct CartView: View {
    
//    @Environment(\.modelContext) private var modelContext
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
//            .onDelete(perform: deleteProduct)
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
    
    //delete product
//    private func deleteProduct(indexes: IndexSet) {
////        for index in indexes {
////            modelContext.delete(trip.products[index])
////        }
//        
//        for index in indexes {
//                    let objectId = trip.products[index].persistentModelID
//                    if let productToDelete = modelContext.model(for: objectId) as? Product {
//                        modelContext.delete(productToDelete)
//                    }
//                }
//                trip.products.remove(atOffsets: indexes)
//                
//                do {
//                    try modelContext.save()
//                } catch {
//                    print("Error saving context \(error)")
//                }
//        
//    }
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

