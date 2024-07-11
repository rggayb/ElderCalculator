//
//  QuantityInput.swift
//  ElderCalculator
//
//  Created by James Cellars on 10/07/24.
//

import SwiftUI

struct QuantityInput: View {
    @Binding var quantity: String
    
    var body: some View {
        HStack {
            Text("Quantity:")
                .font(.headline)
            TextField("Enter quantity", text: $quantity)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    QuantityInput(quantity: .constant(""))
}
