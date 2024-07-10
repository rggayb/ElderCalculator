//
//  ItemList.swift
//  ElderCalculator
//
//  Created by James Cellars on 10/07/24.
//

import SwiftUI

struct ItemList: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if !viewModel.items.isEmpty {
                    Text("Items:")
                        .font(.title2)
                        .padding(.top)
                    ForEach(viewModel.items.reversed()) { item in
                        HStack {
                            Text("\(item.category): \(item.price, specifier: "%.2f") x \(item.quantity)")
                            Spacer()
                            Button(action: {
                                viewModel.removeItem(item: item)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ItemList(viewModel: HomeViewModel())
}
