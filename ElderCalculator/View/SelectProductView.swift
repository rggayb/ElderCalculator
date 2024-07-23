//
//  SelectProductNameView.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 22/07/24.
//

import SwiftUI

struct SelectProductView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var selectProductViewModel = SelectProductViewModel()
    @Binding var selectedProduct: ProductInfo?
    
    var body: some View {
        NavigationView {
            
            VStack {
                //textfield
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search product", text: $selectProductViewModel.searchText)
                        
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .padding(.horizontal)
                
                //list product name & image
                List {
                    ForEach (selectProductViewModel.filteredProducts.sorted(by: > )) { product in
                        HStack  {
                            Image(product.imageName)
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(product.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .scaledToFit()
                                .minimumScaleFactor(0.6)
                                .padding()
                        }
                        .onTapGesture {
                            selectedProduct = product
                            dismiss()
                        }
                        
                    }
                    
                    
                    //if no product match the search, show the new product from search text
                    if selectProductViewModel.searchText.isEmpty == false && selectProductViewModel.filteredProducts.isEmpty {
                        
                        HStack  {
                            Image("defaultProduct")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(selectProductViewModel.searchText)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .scaledToFit()
                                .minimumScaleFactor(0.6)
                                .padding()
                        }
                        .onTapGesture {
                            let newProduct = ProductInfo(name: selectProductViewModel.searchText, imageName: "defaultProduct")
                            selectedProduct = newProduct
                            dismiss()
                        }
                        
                    }
                    
                }
            }
            .navigationTitle("Select Product")
        }
    }
}

#Preview {
    SelectProductView(selectedProduct: .constant(nil))
}
