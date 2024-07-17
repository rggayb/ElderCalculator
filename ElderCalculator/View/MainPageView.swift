//
//  MainPageView.swift
//  ElderCalculator
//
//  Created by Vincent Saranang on 12/07/24.
//

import SwiftUI

struct MainPageView: View {
    @State private var isAddNewTripPresented: Bool = false
    @State private var isDatePickerPresented: Bool = false
    @StateObject var viewModel = ShoppingTripViewModel(inMemory: false)
    
    
    var body: some View {
        // full background
        ZStack {
            NavigationView{
                VStack(spacing:32){
                    // Shopping trip + container
                    VStack(spacing:24){
                        // Label & button action
                        HStack{
                            Text("Shopping Trip")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.textColor1)
                            Spacer()
                            // Add trips
                            Button(action: {
                                viewModel.resetTripForm()
                                isAddNewTripPresented.toggle()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(.buttonColor1)
                            }
                            .sheet(isPresented: $isAddNewTripPresented) {
                                AddNewTripView(viewModel: viewModel)
                                    .presentationDragIndicator(.visible)
                            }
                        }
                        
                        // Inside Container
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: UIScreen.main.bounds.height/4)
                            .overlay{
                                ZStack {
                                    // detail container
                                    VStack{
                                        HStack {
                                            VStack(alignment: .leading, spacing: 8){
                                                Text("Total Expense")
                                                    .font(.system(size: 20, weight: .semibold))
                                                // value total expense bulan itu (mesti diganti variable)
                                                Text("Rp \(viewModel.totalExpense, specifier: "%.0f")")
                                                    .font(.system(size: 40, weight: .bold))
                                            }
                                            .foregroundStyle(.textColor1)
                                            Spacer()
                                        }
                                        
                                        Spacer()
                                        
                                        HStack{
                                            VStack(alignment: .leading){
                                                HStack(spacing:4){
                                                    Image(systemName: "doc.plaintext.fill")
                                                        .font(.system(size: 16, weight: .semibold))
                                                    Text("Tax")
                                                        .font(.system(size: 16, weight: .semibold))
                                                }
                                                Text("Rp \(Int(viewModel.totalTax))")
                                                    .font(.system(size: 20, weight: .semibold))
                                            }
                                            Spacer()
                                            VStack(alignment: .leading){
                                                HStack(spacing:4){
                                                    Image(systemName: "banknote.fill")
                                                        .font(.system(size: 16, weight: .semibold))
                                                    Text("Saved")
                                                        .font(.system(size: 16, weight: .semibold))
                                                }
                                                Text("Rp \(Int(viewModel.totalDiscount))")
                                                    .font(.system(size: 20, weight: .semibold))
                                            }
                                        }
                                        .foregroundStyle(.textColor1)
                                    }
                                    .padding()
                                    
                                    // date
                                    VStack {
                                        HStack {
                                            Spacer()
                                            
                                            RoundedRectangle(cornerRadius: 6)
                                                .foregroundColor(.containerColor1)
                                                .frame(width: UIScreen.main.bounds.width/4, height: 34)
                                                .overlay{
                                                    Text(DateFormatter.monthYear.string(from:viewModel.selectedDate))
                                                        .foregroundStyle(.textColor1)
                                                        .font(.system(size: 16, weight: .semibold))
                                                }
                                        }
                                        Spacer()
                                        
                                    }
                                    .padding([.top, .trailing])
                                }
                                .foregroundColor(.textColor2)
                                .background(Image(.cardBackground1)
                                    .resizable())
                            }
                        
                    }
                    .onTapGesture {
                        isDatePickerPresented.toggle()
                    }
                    .sheet(isPresented: $isDatePickerPresented){
                        DatePickerView(viewModel: viewModel)
                            .presentationDetents([.height(UIScreen.main.bounds.width+32)])
                            .presentationDragIndicator(.visible)
                    }
                    
                    // Recent trip
                    VStack(spacing:12){
                        HStack {
                            Text("Recent Trip")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.textColor3)
                            Spacer()
                        }
                        
                        if viewModel.trips.isEmpty {
                            Spacer()
                            VStack(spacing:24){
                                Image(.noTrip)
                                    .frame(width: 131, height: 128)
                                VStack(spacing:8){
                                    Text("No Trips Yet?")
                                        .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.textColor3)
                                    Text("Tap the \(Image(systemName: "plus.circle.fill")) button to add\na new trip to your list.")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(.textColor4)
                                }
                            }
                            .multilineTextAlignment(.center)
                            Spacer()
                            
                        } else {
                            List {
                                ForEach(viewModel.trips) { trip in
                                    let cartViewModel = CartViewModel(trip: trip)
                                    NavigationLink(destination:
                                        ShoppingCartPageView(trip: trip, viewModel: viewModel, cartViewModel: cartViewModel)){
                                        HStack(spacing:12){
                                            RoundedRectangle(cornerRadius: 6)
                                                .frame(width: 48, height: 48)
                                                .foregroundColor(.white)
                                                .overlay{
                                                    Image(systemName: "cart.fill")
                                                        .foregroundColor(.iconColor1)
                                                }
                                            
                                            VStack(alignment:.leading){
                                                Text(trip.storeName)
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundColor(.textColor3)
                                                Text(trip.date,
                                                     format: Date.FormatStyle(date: .long, time: .none))
                                                    .font(.system(size: 12, weight: .regular))
                                                    .foregroundColor(.textColor4)
                                            }
                                            
                                            Spacer()
                                            
                                            Text("Rp \(Int(cartViewModel.totalExpense))")
                                                .font(.system(size: 20, weight: .semibold))
                                                .foregroundColor(.textColor3)
                                        }
                                    }
                                }
                                .onDelete(perform: {
                                    indexes in viewModel.deleteTrip(at: indexes)
                                    // change date to now
                                    viewModel.selectedDate = Date()
                                    // recalculate card for selected month
                                    viewModel.calculateTotalsForSelectedMonth()
                                })
                                .listRowSeparator(.hidden)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.containerColor2)
                                    // klo over budget .containerColor3
                                )
                                .frame(height: 64)
                            }
                            .frame(width: UIScreen.main.bounds.width)
                            .listStyle(.plain)

                        }
                        Spacer()
                    }
                    
                }
                .navigationTitle("Shopping Trip")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("")
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 32)
            }
            .accentColor(.buttonColor2)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.colorbackground1)
    }
}

#Preview {
    MainPageView()
}
