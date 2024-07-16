//
//  PriceInput.swift
//  ElderCalculator
//
//  Created by James Cellars on 09/07/24.
//

import SwiftUI

struct PriceInput: View {
    @Binding var price: String
    
    var body: some View {
        HStack {
            Text("Price:")
                .font(.headline)
            TextField("Enter price", text: $price)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    PriceInput(price: .constant(""))
}
