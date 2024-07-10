//
//  TotalSpendings.swift
//  ElderCalculator
//
//  Created by James Cellars on 09/07/24.
//

import SwiftUI

struct TotalSpendings: View {
    var total: Double
    
    var body: some View {
        HStack {
            Text("Total Spendings:")
                .font(.largeTitle)
                .bold()
            Spacer()
            Text(String(format: "%.2f", total))
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
}

#Preview {
    TotalSpendings(total: 0.0)
}
