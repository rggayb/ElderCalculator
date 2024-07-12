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
    @ObservedObject var viewModel: HomeViewModel
    
    
    @State private var productName: String = ""
    @State private var productPrice: String = ""
    @State private var productQuantity: String = ""
    @State private var productDiscount: String = ""
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView {
                VStack {
                    //Tax toggle
                    TaxToggle(isTaxIncluded: $viewModel.isTaxIncluded)
                    
                    //Total spendings
                    TotalSpendings(total: viewModel.total)
                    
                    //Category input
                    CategoryInput(selectedCategory: $viewModel.selectedCategory, categories: viewModel.categories)
                    
                    //Price input
                    PriceInput(price: $viewModel.price)
                    
                    //Quantity input
                    QuantityInput(quantity: $viewModel.quantity)
                    
                    //Discount input
                    DiscountInput(discount: $viewModel.discount)
                    
                    //Calculate button
                    Button(action: viewModel.addItem) {
                        Text("Add item")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    //Item list
                    ItemList(viewModel: viewModel)
                }
            }
            .padding()
        }

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

