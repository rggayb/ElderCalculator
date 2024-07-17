//
//  AddNewTripView.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import SwiftUI
import SwiftData

struct AddNewTripView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ShoppingTripViewModel
    
    var body: some View {
        // full background
        ZStack {
            VStack{
                VStack(spacing: 48){
                    // headline
                    VStack(spacing: 8){
                        Text("Get ready to shop")
                            .font(.system(size: 32, weight: .bold))
                        Text("Input the store name and\nstate your budget.")
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
                                        TextField("Name", text: $viewModel.storeName)
                                            .disableAutocorrection(true)
                                    }
                                    Divider()
                                    HStack{
                                        Text("Budget\t\t")
                                            .font(.system(size: 16, weight: .semibold))
                                        HStack(spacing:4){
                                            Text("Rp")
                                                .foregroundColor(.textColor5)
                                            TextFieldWithDoneButton(text: $viewModel.budget, placeholder: "")
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
                                            Spacer()
                                            HStack(spacing:8){
                                                TextFieldWithDoneButton(text: $viewModel.tax, placeholder: "0", alignment: .right)
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
                    viewModel.addTrip(
                        storeName: viewModel.storeName,
                        budget: Double(viewModel.budget) ?? 0,
                        tax: Int(viewModel.tax) ?? 0
                    )
                    // change date to now
                    viewModel.selectedDate = Date()
                    // recalculate card for selected month
                    viewModel.calculateTotalsForSelectedMonth()
                    
                    dismiss()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .foregroundColor(viewModel.isTripValid() ? .iconColor1 : .containerColor1.opacity(4/3))
                        .overlay{
                            Text("Start Shopping")
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

#Preview {
    AddNewTripView(viewModel: ShoppingTripViewModel(inMemory: true))
}
