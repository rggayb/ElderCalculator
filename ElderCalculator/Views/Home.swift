//
//  Home.swift
//  ElderCalculator
//
//  Created by James Cellars on 09/07/24.
//

import SwiftUI

struct Home: View {
    @State private var price = ""
    @State private var discount = ""
    @State private var total = 0.0
    @State var isTaxIncluded = false
    
    let taxPercentage = 0.11
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                //Tax toggle
                TaxToggle(isTaxIncluded: $isTaxIncluded)
                
                //Total spendings
                TotalSpendings(total: total)
                
                //Price input
                PriceInput(price: $price)
                
                //Discount input
                DiscountInput(discount: $discount)
                
                //Calculate button
                Button(action: calculateTotal) {
                    Text("Add item")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }
    
    //Calculate total spending
    func calculateTotal() {
        let priceValue = Double(price) ?? 0.0
        let discountValue = (Double(discount) ?? 0.0) / 100.0
        var totalValue = priceValue - (priceValue * discountValue)
        
        //Includes tax if toggle is on
        if isTaxIncluded {
            totalValue += totalValue * taxPercentage
        }
        
        total += totalValue
    }
}

#Preview {
    Home()
}
