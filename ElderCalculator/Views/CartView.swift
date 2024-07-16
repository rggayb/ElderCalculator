//
//  CartView.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import SwiftUI
import SwiftData

struct CartView: View {
    @Bindable var trip: Trip
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var productName: String = ""
    @State private var productPrice: String = ""
    @State private var productQuantity: String = ""
    @State private var productDiscount: String = ""
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    Text("Budget: \(trip.budget, specifier: "%.2f") Rp")
                        .font(.headline)
                        .padding()
                    
                    TaxToggle(isTaxIncluded: $viewModel.isTaxIncluded)
                    TotalSpendings(total: viewModel.total)
                    CategoryInput(selectedCategory: $viewModel.selectedCategory, categories: viewModel.categories)
                    PriceInput(price: $viewModel.price)
                    QuantityInput(quantity: $viewModel.quantity)
                    DiscountInput(discount: $viewModel.discount)
                    Button(action: {
                        viewModel.addItem()
                        AddItemSound.shared.playSound(named: "ScanSound")
                        AddItemSound.shared.triggerHapticFeedback()
                    }) {
                        Text("Add item")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    ItemList(viewModel: viewModel)
                }
            }
            .padding()
        }
    }
}


