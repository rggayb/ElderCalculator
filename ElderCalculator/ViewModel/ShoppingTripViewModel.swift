//
//  ShoppingTripViewModel.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 10/07/24.
//

import SwiftUI
import SwiftData

class ShoppingTripViewModel: ObservableObject {
    
    @Published var trips: [Trip] = []
    @Published var products: [Product] = []
    @Published var error: Error? = nil
    @Published var isTaxIncluded = false
    @Published var price = ""
    @Published var discount = ""
    @Published var quantity = ""
    @Published var selectedCategory = ""
    @Published var total = 0.0
    @Published var items: [Item] = []
    
    enum OtherErrors: Error {
        case nilContext
    }
    
    var modelContext: ModelContext? = nil
    var modelContainer: ModelContainer? = nil
    
    @MainActor
    init(inMemory: Bool) {
        do {
            // container init
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            let container = try ModelContainer(for: Trip.self, Product.self, configurations: configuration)
            modelContainer = container
            
            // get model context
            modelContext = container.mainContext
            modelContext?.autosaveEnabled = true
            
            // query data
            queryTrips()
            queryProducts()
            
        } catch(let error) {
            print(error)
            print(error.localizedDescription)
            self.error = error
        }
    }
    
    func queryTrips() {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        
        var tripDescriptor = FetchDescriptor<Trip>(
            predicate: nil,
            sortBy: [
                .init(\.date)
            ]
        )
        tripDescriptor.fetchLimit = 10
        do {
            trips = try modelContext.fetch(tripDescriptor)
        } catch(let error) {
            self.error = error
        }
    }
    
    private func queryProducts() {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        let productDescriptor = FetchDescriptor<Product>()
        do {
            products = try modelContext.fetch(productDescriptor)
        } catch(let error) {
            self.error = error
        }
    }
    
    func addTrip(storeName: String, budget: Double, tax: Int) {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        let date = Date()
        let newTrip = Trip(
            date: date,
            storeName: storeName,
            budget: Double(budget),
            tax: Int(tax))
        modelContext.insert(newTrip)
        save()
        queryTrips()
    }
    
    func addNewProduct(name: String, price: Double, quantity: Int, discount: Int, trip: Trip) {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        
        let newProduct = Product(
            name: name,
            price: price,
            quantity: quantity,
            discount: discount
        )
        modelContext.insert(newProduct)
        trip.addProduct(newProduct)
    }
    
    func deleteTrip(at offsets: IndexSet) {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        for index in offsets {
            let trip = trips[index]
            modelContext.delete(trip)
        }
        save()
        queryTrips()
    }
    
    // Reset HomeViewModel when preparing a new trip
    func prepareNewTrip(trip: Trip) -> HomeViewModel {
        let homeViewModel = HomeViewModel(trip: trip)
        homeViewModel.removeAllItems()
        return homeViewModel
    }
    
    // saving any pending changes
    private func save() {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        do {
            try modelContext.save()
        } catch (let error) {
            print(error)
            self.error = error
        }
    }
}

