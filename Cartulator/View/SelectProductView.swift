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
            VStack(spacing:0){
                //textfield
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width-32, height: 36)
                    .foregroundColor(.containerColor1)
                    .overlay{
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Search product", text: $selectProductViewModel.searchText)
                                .disableAutocorrection(true)
                            
                        }
                        .padding(8)
                        .foregroundColor(.textColor4)
                    }
                
                //list product name & image
                List {
                    ForEach (selectProductViewModel.filteredProducts.sorted(by: > )) { product in
                        HStack(spacing:16){
                            Image(product.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text(product.name)
                                .font(.system(size: 16, weight: .semibold))
                                .padding(8)
                            Spacer()
                        }
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            selectedProduct = product
                            dismiss()
                        }
                        .listRowBackground(Color(.containerColor3))
                    }
                    
                    
                    //if no product match the search, show the new product from search text
                    if selectProductViewModel.searchText.isEmpty == false && selectProductViewModel.filteredProducts.isEmpty {
                        
                        HStack  {
                            Image("defaultProduct")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(selectProductViewModel.searchText)
                                .font(.system(size: 16, weight: .semibold))
                                .padding(12)
                        }
                        .onTapGesture {
                            let newProduct = ProductInfo(name: selectProductViewModel.searchText, imageName: "defaultProduct")
                            selectedProduct = newProduct
                            dismiss()
                        }
                        
                    }
                    
                }
                .background(.colorBackground2)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Select Product")
            .background(.colorBackground2)
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SelectProductView(selectedProduct: .constant(nil))
}
