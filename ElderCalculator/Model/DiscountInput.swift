//
//  DiscountInput.swift
//  ElderCalculator
//
//  Created by James Cellars on 09/07/24.
//

import SwiftUI

struct DiscountInput: View {
    @Binding var discount: String
    
    var body: some View {
        HStack {
            Text("Discount (%):")
                .font(.headline)
            TextField("Enter discount", text: $discount)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    DiscountInput(discount: .constant(""))
}
