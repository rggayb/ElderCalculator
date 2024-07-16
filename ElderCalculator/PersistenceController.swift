//
//  PersistenceController.swift
//  ElderCalculator
//
//  Created by James Cellars on 11/07/24.
//

import Foundation
import SwiftData
import SwiftUI

class PersistenceController: ObservableObject {
    static let shared = PersistenceController()
    
    @AppStorage("items") private var itemsData: Data = Data()
    
    @Published var items: [Item] = []
    
    init() {
        loadItems()
    }
    
    func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            itemsData = encoded
        }
    }
    
    func loadItems() {
        if let decoded = try? JSONDecoder().decode([Item].self, from: itemsData) {
            items = decoded
        }
    }
}
