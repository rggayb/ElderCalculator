//
//  ShoppingTripView.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import SwiftUI
import SwiftData

struct ShoppingTripView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]
    @State private var isAddNewTripPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(trips) { trip in NavigationLink {
                    CartView(trip: trip)
                } label: {
                    VStack(alignment: .leading) {
                        Text(trip.date,
                             format: Date.FormatStyle(date: .numeric, time: .standard))
                        Text(trip.storeName)
                        Text(String(trip.storeDiscount))
                    }
                }
                }
                .onDelete(perform: deleteTrip)
                
            }
            .toolbar {
                //edit button
                ToolbarItem (placement: .navigationBarTrailing) {
                    EditButton()
                }
                //add button
                ToolbarItem {
                    Button {
                        isAddNewTripPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
            //AddNewTripView modality
            .sheet(isPresented: $isAddNewTripPresented) {
                AddNewTripView()
            }
            
            .navigationTitle("My Trips")
        }
    }
    
    
    
    
    //delete trip
    private func deleteTrip(indexes: IndexSet) {
        for index in indexes {
            modelContext.delete(trips[index])
        }
    }
    
    
}


#Preview {
    ShoppingTripView()
        .modelContainer(for: Trip.self, inMemory: true)
}
