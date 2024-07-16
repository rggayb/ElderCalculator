//
//  CategoryInput.swift
//  ElderCalculator
//
//  Created by James Cellars on 10/07/24.
//

import SwiftUI

struct CategoryInput: View {
    @Binding var selectedCategory: String
    let categories: [String]
    
    var body: some View {
        HStack {
            Text("Category:")
                .font(.headline)
            Spacer()
            Picker("Select category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category).tag(category)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
        }
        .padding()
    }
}

#Preview {
    CategoryInput(selectedCategory: .constant(""), categories: ["Fruit", "Vegetable", "Dairy", "Meat"])
}
