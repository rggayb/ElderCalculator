//
//  SelectProductNameViewModel.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 22/07/24.
//

import Foundation

class SelectProductViewModel: ObservableObject {
    @Published var searchText: String = ""
    private var products: [ProductInfo] = ProductInfoData.productsInfo
    
    var filteredProducts: [ProductInfo] {
        
        if searchText.isEmpty {
            return products
            
        } else {
            
            return products.filter { product in
                
                let searchTextLowercased = searchText.lowercased()
                let productNameLowercased = product.name.lowercased()
                
                return productNameLowercased.contains(searchTextLowercased)
                
            }
        }
        
    }
}
