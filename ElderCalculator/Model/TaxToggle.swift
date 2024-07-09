//
//  TaxToggle.swift
//  ElderCalculator
//
//  Created by James Cellars on 09/07/24.
//

import SwiftUI

struct TaxToggle: View {
    @Binding var isTaxIncluded: Bool
    var body: some View {
        Toggle(isOn: $isTaxIncluded) {
            Text("Include Tax")
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding()
    }
}

#Preview {
    TaxToggle(isTaxIncluded: .constant(false))
}
