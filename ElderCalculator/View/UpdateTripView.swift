//
//  UpdateTripView.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 16/07/24.
//

import SwiftUI

struct UpdateTripView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var trip: Trip
    @ObservedObject var viewModel: ShoppingTripViewModel
    
    var body: some View {
        // full background
        ZStack {
            VStack{
                VStack(spacing: 48){
                    // headline
                    VStack(spacing: 8){
                        Text("Update Store Details")
                            .font(.system(size: 32, weight: .bold))
                        Text("Change the store name, revise your budget, and update the tax rate.")
                            .font(.system(size: 20, weight: .regular))
                            .multilineTextAlignment(.center)
                    }
                    
                    // all below headline
                    VStack(spacing:16){
                        // store and budget
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 88)
                            .foregroundColor(.containerColor3)
                            .overlay{
                                VStack{
                                    HStack{
                                        Text("Store\t\t")
                                            .font(.system(size: 16, weight: .semibold))
                                        TextField("\(trip.storeName)", text: $viewModel.storeName)
                                            .disableAutocorrection(true)
                                    }
                                    Divider()
                                    HStack{
                                        Text("Budget\t\t")
                                            .font(.system(size: 16, weight: .semibold))
                                        HStack(spacing:4){
                                            Text("Rp")
                                                .foregroundColor(.textColor5)
                                            TextFieldWithDoneButton(text: $viewModel.budget, placeholder: "\(Int(trip.budget))", alignment: .left)
                                        }
                                    }
                                }
                                .padding()
                            }
                        
                        // specify tax
                        VStack {
                            Section(header:
                                HStack {
                                    Text("Specify Tax Percentage for this Store")
                                    .font(.system(size: 16, weight: .semibold))
                                    Spacer()
                                }
                            ){
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 44)
                                    .foregroundColor(.containerColor3)
                                    .overlay{
                                        HStack{
                                            Text("Tax")
                                                .font(.system(size: 16, weight: .semibold))
                                            HStack {
                                                TextField("\(trip.tax)", text: $viewModel.tax)
                                                    .keyboardType(.numberPad)
                                                    .multilineTextAlignment(.trailing)
                                                Text("% VAT")
                                            }
                                        }
                                        .padding()
                                    }
                            }
                        }
                    }
                }
                .foregroundColor(.textColor3)
                
                Spacer()
                Button (action: {
                    viewModel.updateTrip(
                        trip: trip,
                        storeName: viewModel.storeName,
                        budget: Double(viewModel.budget) ?? trip.budget,
                        tax: Int(viewModel.tax) ?? trip.tax
                    )
                    dismiss()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .foregroundColor(viewModel.isTripValid() ? .iconColor1 : .containerColor1.opacity(4/3))
                        .overlay{
                            Text("Save")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(viewModel.isTripValid() ? .textColor7 : .textColor5)
                                .padding()
                        }
                }
                .disabled(!viewModel.isTripValid())
            }
            .frame(width: UIScreen.main.bounds.width-48)
            .padding(.vertical, 48)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.colorBackground2)
    }
}

//#Preview {
//    UpdateTripView(trip: Trip, viewModel: ShoppingTripViewModel(inMemory: true))
//}
