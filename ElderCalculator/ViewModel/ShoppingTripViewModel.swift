//
//  ShoppingTripViewModel.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 10/07/24.
//

import SwiftUI
import SwiftData

class ShoppingTripViewModel: ObservableObject {
    
    @Published var trips: [Trip] = [] {
        didSet {
            calculateTotals()
        }
    }
    
    @Published var products: [Product] = [] {
        didSet {
            calculateTotals()
        }
    }
    
    @Published var error: Error? = nil
    
    @Published var totalExpense: Double = 0.0
    @Published var totalTax: Double = 0.0
    @Published var totalDiscount: Double = 0.0
    
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
            budget: Double(budget) ,
            tax: Int(tax))
        modelContext.insert(newTrip)
        save()
        queryTrips()
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
    
    func addNewProduct(name: String, price: Double, quantity: Int, discount: Int, totalPrice: Double, trip: Trip) {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        
        let newProduct = Product(
            name: name,
            price: price,
            quantity: quantity,
            discount: discount,
            totalPrice: totalPrice
            
        )
        modelContext.insert(newProduct)
        trip.addProduct(newProduct)
    }
    
    func deleteProduct(indexes: IndexSet, from trip: Trip) {
        
        for index in indexes {
            let objectId = trip.products[index].persistentModelID
            if let productToDelete = modelContext?.model(for: objectId) as? Product {
                modelContext?.delete(productToDelete)
            }
        }
        trip.products.remove(atOffsets: indexes)
        
        do {
            try modelContext?.save()
        } catch {
            print("Error saving context \(error)")
        }
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
    
    //mainpageviewmodel:
    func calculateTotals() {
        //reset value
        totalExpense = 0
        totalTax = 0
        totalDiscount = 0
        
        for trip in trips {
            for product in trip.products {
                totalExpense += product.totalPrice
                totalTax += product.price * Double(trip.tax) / 100
                totalDiscount += (product.price * Double(product.discount) / 100) * Double(product.quantity)
            }
        }
    }
    
    //Calculate total spendings for current month
    var monthlyTotalSpendings: Double {
        let calendar = Calendar.current
        let currentDate = Date()
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        
        return trips.filter { trip in
            let tripMonth = calendar.component(.month, from: trip.date)
            let tripYear = calendar.component(.year, from: trip.date)
            return tripMonth == currentMonth && tripYear == currentYear
        }.reduce(0.0) { total, trip in
            total + trip.products.reduce(0.0) { $0 + $1.price * Double($1.quantity)}
        }
    }
}
