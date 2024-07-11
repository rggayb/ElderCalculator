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
    
    @State var storeName: String = ""
    @State var budget: String = ""
    @State var tax: String = ""
    
    var body: some View {
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
                    .foregroundColor(Color(hex: "F2F2F7"))
                    .overlay{
                        VStack{
                            HStack{
                                Text("Store\t\t")
                                TextField("Name", text: $storeName)
                                    .disableAutocorrection(true)
                            }
                            Divider()
                            HStack{
                                Text("Budget\t\t")
                                HStack(spacing:4){
                                    Text("Rp")
                                        .foregroundColor(Color(hex:"BCBCC0"))
                                    TextField("", text: $budget)
                                        .keyboardType(.numberPad)
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
                                .font(.sf(size: 16, weight: .semibold))
                            Spacer()
                        }
                    ){
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 44)
                            .foregroundColor(Color(hex: "F2F2F7"))
                            .overlay{
                                HStack{
                                    Text("Tax")
                                    HStack {
                                        TextField("11", text: $tax)
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
            Spacer()
            Button (action: {
                viewModel.addTrip(
                    storeName: storeName,
                    budget: Double(budget) ?? 0,
                    tax: Int(tax) ?? 0
                )
                dismiss()
            }) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: .infinity, height: 50)
                    .overlay{
                        Text("Save")
                            .foregroundColor(.white)
                            .padding()
                    }
            }
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .frame(width: UIScreen.main.bounds.width-48)
        .padding(.vertical, 48)
    }
}

#Preview {
    AddNewTripView(viewModel: ShoppingTripViewModel(inMemory: true))
}
