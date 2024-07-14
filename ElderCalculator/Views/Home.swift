//
//  Home.swift
//  ElderCalculator
//
//  Created by James Cellars on 09/07/24.
//

import SwiftUI

struct Home: View {
    @StateObject private var viewModel: HomeViewModel
    
    init(trip: Trip) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(trip: trip))
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    // Tax toggle
                    TaxToggle(isTaxIncluded: $viewModel.isTaxIncluded)
                    
                    // Total spendings
                    TotalSpendings(total: viewModel.total)
                    
                    // Category input
                    CategoryInput(selectedCategory: $viewModel.selectedCategory, categories: viewModel.categories)
                    
                    // Price input
                    PriceInput(price: $viewModel.price)
                    
                    // Quantity input
                    QuantityInput(quantity: $viewModel.quantity)
                    
                    // Discount input
                    DiscountInput(discount: $viewModel.discount)
                    
                    // Calculate button
                    Button(action: viewModel.addItem) {
                        Text("Add item")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    // Item list
                    ItemList(viewModel: viewModel)
                }
            }
            .padding()
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, visionOS 1.0, watchOS 10.0, *)
struct Home_Preview: PreviewProvider {
    static var previews: some View {
        let sampleTrip = Trip(date: Date(), storeName: "Test Store", budget: 100, tax: 10)
        Home(trip: sampleTrip)
    }
}

