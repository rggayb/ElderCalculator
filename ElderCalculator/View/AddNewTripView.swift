//
//  AddNewTripView.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import SwiftUI
import SwiftData

struct AddNewTripView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
//    @StateObject var viewModel = ShoppingTripViewModel(inMemory: false)
    @ObservedObject var viewModel: ShoppingTripViewModel
    
    @State var storeName: String = ""
    @State var storeType: String = ""
    @State var budget: String = ""
    @State var tax: String = ""
    @State var storeDiscount: String = ""
//    @State var products: [Product]
    
    var body: some View {
        Form {
            Section {
                TextField("Store name", text: $storeName)
                TextField("Store type", text: $storeType)
                TextField("budget", text: $budget)
                    .keyboardType(.decimalPad)
                TextField("tax", text: $tax)
                    .keyboardType(.numberPad)
                TextField("store discount", text: $storeDiscount)
                    .keyboardType(.decimalPad)
            }
            
            Button (action: {
                viewModel.addTrip(
                    storeName: storeName,
                    storeType: storeType,
                    budget: Double(budget) ?? 0,
                    tax: Int(tax) ?? 0,
                    storeDiscount: Double(storeDiscount) ?? 0)
                dismiss()
            }) {
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
    
//    private func addNewTrip() {
//        let newTrip = Trip(date: Date(),
//                           storeName: storeName,
//                           storeType: storeType,
//                           budget: Double(budget) ?? 0,
//                           tax: Int(tax) ?? 0,
//                           storeDiscount: Double(storeDiscount) ?? 0)
//        modelContext.insert(newTrip)
//    }
}

#Preview {
    AddNewTripView(viewModel: ShoppingTripViewModel(inMemory: true))
}
