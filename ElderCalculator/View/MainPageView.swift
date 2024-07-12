//
//  MainPageView.swift
//  ElderCalculator
//
//  Created by Vincent Saranang on 12/07/24.
//

import SwiftUI

struct MainPageView: View {
    @State private var isAddNewTripPresented: Bool = false
    @StateObject var viewModel = ShoppingTripViewModel(inMemory: false)
    
    var body: some View {
        // full background
        ZStack {
            VStack(spacing:32){
                // Shopping trip + container
                VStack(spacing:16){
                    // Label & button action
                    HStack{
                        Text("Shopping Trip")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.textColor1)
                        Spacer()
                        // Add trips
                        Button(action: {
                            isAddNewTripPresented.toggle()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.buttonColor1)
                        }
                        .sheet(isPresented: $isAddNewTripPresented) {
                            AddNewTripView(viewModel: viewModel)
                        }
                    }
                    
                    // Container
                    // buat bisa di click, tinggal button buat pop ganti tanggal atau kalo mau diganti by chevron kiri kanan atau slider jg bisa
                    RoundedRectangle(cornerRadius: 10)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .frame(height: UIScreen.main.bounds.height/4)
                        .overlay{
                            ZStack {
                                // detail container
                                VStack{
                                    HStack {
                                        VStack(alignment: .leading, spacing: 8){
                                            Text("Total Expense")
                                                .font(.system(size: 20, weight: .semibold))
                                            // value total expense bulan itu
                                            Text("Rp 999.900")
                                                .font(.system(size: 40, weight: .semibold))
                                        }
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
                                            // value total tax bulan itu
                                            Text("Rp 108.900")
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
                                            // value total discount bulan itu
                                            Text("Rp 99.000")
                                                .font(.system(size: 20, weight: .semibold))
                                        }
                                    }
                                }
                                .padding()
//                                .padding(.vertical)
                                
                                // date
                                VStack {
                                    HStack {
                                        // biar dikanan
                                        Spacer()
                                        
                                        RoundedRectangle(cornerRadius: 6)
                                            .foregroundColor(.containerColor1)
                                            .frame(width: UIScreen.main.bounds.width/4, height: 34)
                                            .overlay{
                                                // Date picker atau data date dari SwiftData as an interface biar bisa dipake buat filtering si card perbulannya
                                                
                                                // dummy
                                                HStack(spacing:5){
                                                    Text("July")
                                                    Text("2024")
                                                }
                                        }
                                    }
                                    // biar diatas
                                    Spacer()
                                    
                                }
//                                .padding(.top, 32)
                                .padding(.top, 16)
                                .padding(.trailing,16)
                            }
                            .foregroundColor(.containerTextColor1)
                            .background(Image(.containerBackground1))
                        }
                    
                }
                
                // Recent trip
                VStack(spacing:16){
                    HStack {
                        Text("Recent Trip")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.textColor1)
                        Spacer()
                    }
                    
                    // dibuat button + isPresented
                    // isianny (paling pake for each) (nanti yg hstack ini bakal di bikin model yang dimana ngisi store name, tanggal and expensenya
                    HStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.containerColor2)
                            .frame(height: 80)
                            .overlay{
                                HStack(spacing:12){
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 48, height: 48)
                                        .foregroundColor(.white)
                                        .overlay{
                                            Image(systemName: "cart.fill")
                                                .foregroundColor(.iconColor1)
                                        }
                                    
                                    VStack(alignment:.leading){
                                        Text("Store Name")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.textColor2)
                                        Text("Jul 7, 2024")
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(.textColor3)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("Rp999.900")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.textColor2)
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(.iconColor2)
                                }
                                .padding()
                        }
                    }
                    Spacer()
                    
//                    Spacer()
//                    VStack{
//                        Image("noItemImage")
//                            .frame(width: 172, height: 172)
//                        Text("No Trips Yet?")
//                            .font(.system(size: 20, weight: .semibold))
//                        Text("Tap the 􀁍 button to add\na new trip to your list.")
//                            .font(.system(size: 16))
//                            
//                    }
//                    .multilineTextAlignment(.center)
//                    Spacer()
//                    Spacer()

                }
                
            }
            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            .frame(width: UIScreen.main.bounds.width-32)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color(.backgroundColor1))
    }
}

#Preview {
    MainPageView()
}
