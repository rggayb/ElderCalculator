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
    
    func addTrip(storeName: String, storeType: String, budget: Double, tax: Int, storeDiscount: Double) {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        let date = Date()
        let newTrip = Trip(
            date: date,
            storeName: storeName,
            storeType: storeType,
            budget: Double(budget) ,
            tax: Int(tax) ,
            storeDiscount: Double(storeDiscount))
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
////    @Query(sort: \Trip.date, order: .reverse) private var tripsQuery: [Trip]
//
//    var trips: [Trip] = []
//
//    private var modelContext: ModelContext?
//
//    func deleteTrip(at offsets: IndexSet) {
//        guard let modelContext = modelContext else { return }
//        for index in offsets {
//            let trip = trips[index]
//            modelContext.delete(trip)
//        }
//        saveContext()
//    }
//
//    private func saveContext() {
//        guard let modelContext = modelContext else { return }
//        do {
//            try modelContext.save()
//        } catch {
//            print("Error saving context: \(error)")
//        }
//    }
//
//    func setModelContext(_ context: ModelContext) {
//        self.modelContext = context
//    }



