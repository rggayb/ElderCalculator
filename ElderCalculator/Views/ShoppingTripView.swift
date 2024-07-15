//
//  ShoppingTripView.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import SwiftUI
import SwiftData

struct ShoppingTripView: View {
    @State private var isAddNewTripPresented: Bool = false
    @StateObject var viewModel = ShoppingTripViewModel(inMemory: false)
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Total Monthly Spendings: \(viewModel.monthlyTotalSpendings, format: .currency(code: "USD"))")
                    .font(.headline)
                    .padding()
                List {
                    ForEach(viewModel.trips) { trip in
                        NavigationLink(destination: CartView(trip: trip, viewModel: HomeViewModel(trip: trip))) {
                            VStack(alignment: .leading) {
                                Text(trip.date, format: Date.FormatStyle(date: .numeric, time: .standard))
                                Text(trip.storeName)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteTrip)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button {
                            isAddNewTripPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $isAddNewTripPresented) {
                    AddNewTripView(viewModel: viewModel)
                }
                .navigationTitle("My Trips")
            }
        }
    }
}

#Preview {
    ShoppingTripView()
        .modelContainer(for: Trip.self, inMemory: true)
}


