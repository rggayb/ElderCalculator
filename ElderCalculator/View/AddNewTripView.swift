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
    @ObservedObject var viewModel: ShoppingTripViewModel
    
    @State var storeName: String = ""
    @State var budget: String = ""
    @State var tax: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Store name", text: $storeName)
                TextField("budget", text: $budget)
                    .keyboardType(.numberPad)
                TextField("tax", text: $tax)
                    .keyboardType(.numberPad)
            }
            
            Button (action: {
                viewModel.addTrip(
                    storeName: storeName,
                    budget: Double(budget) ?? 0,
                    tax: Int(tax) ?? 0
                )
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
}

#Preview {
    AddNewTripView(viewModel: ShoppingTripViewModel(inMemory: true))
}
