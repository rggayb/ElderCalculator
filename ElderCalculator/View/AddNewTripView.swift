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
        ZStack {
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
                        .foregroundColor(Color(hex: "FFFFFF"))
                        .overlay{
                            VStack{
                                HStack{
                                    Text("Store\t\t")
                                        .font(.system(size: 16, weight: .semibold))
                                    TextField("Name", text: $storeName)
                                        .disableAutocorrection(true)
                                        .colorScheme(.light)
                                }
                                Divider()
                                HStack{
                                    Text("Budget\t\t")
                                        .font(.system(size: 16, weight: .semibold))
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
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                            }
                        ){
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 44)
                                .foregroundColor(Color(hex: "FFFFFF"))
                                .overlay{
                                    HStack{
                                        Text("Tax")
                                            .font(.system(size: 16, weight: .semibold))
                                        HStack {
                                            TextField("0", text: $tax)
                                                .keyboardType(.numberPad)
                                                .multilineTextAlignment(.trailing)
                                                .colorScheme(.light)
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
                        .frame(height: 50)
                        // kalo valid
//                        .foregroundColor(.buttonColor2)
                    
                        .overlay{
                            // ini bisa di modif kalo udah ke validasi bisa ganti warna (basednya di figma)
                            Text("Start Shopping")
                                // klo valid
//                                .foregroundColor(.textColor5)
                                .foregroundColor(.white)
                                .padding()
                        }
                }
            }
            .foregroundColor(.textColor4)
            .frame(width: UIScreen.main.bounds.width-48)
            .padding(.vertical, 48)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.backgroundColor2)
    }
}

#Preview {
    AddNewTripView(viewModel: ShoppingTripViewModel(inMemory: true))
}
