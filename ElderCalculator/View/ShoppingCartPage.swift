//
//  ShoppingCartPage.swift
//  ElderCalculator
//
//  Created by Vincent Saranang on 13/07/24.
//

import SwiftUI

struct ShoppingCartPage: View {
    @StateObject var viewModel = ShoppingTripViewModel(inMemory: false)
    
    @State private var isAddNewProductPresented: Bool = false
//    
//    @Bindable var trip: Trip
//    @ObservedObject var viewModel: ShoppingTripViewModel
//    
//    
//    @State private var productName: String = ""
//    @State private var productPrice: String = ""
//    @State private var productQuantity: String = ""
//    @State private var productDiscount: String = ""
    
    var body: some View {
        // full background
        ZStack {
            NavigationView{
                VStack(spacing:32){
                    // Shopping trip + container
                    VStack(spacing:16){
                        // Label & button action
                        HStack{
                            // ganti variable nama toko pake binding maybe?
                            Text("Store name")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.textColor1)
                            Spacer()
                            // Edit Trips
                            Button(action: {
                                
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(.buttonColor1)
                            }
                            // .sheet
                            
                            // Add trips
                            Button(action: {
                                isAddNewProductPresented.toggle()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(.buttonColor1)
                            }
                            // .sheet
                            
                        }
                        
                        // Inside Container
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: UIScreen.main.bounds.height/8)
                            .overlay{
                                ZStack {
                                    // detail container
                                    VStack{
                                        HStack {
                                            VStack(alignment: .leading){
                                                Text("Total Expense")
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundColor(.textColor6)
                                                // value total expense bulan itu
                                                Text("Rp 999.900")
                                                    .font(.system(size: 32, weight: .bold))
                                                // value "bugget left" = "budget yang diset" - "total expense trip itu"
                                                Text("Rp 2.000.100 Budget Left")
                                                    .font(.system(size: 16, weight: .regular))
                                            }
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                    
                                    // date
                                    VStack {
                                        HStack {
                                            Spacer()
                                            RoundedRectangle(cornerRadius: 6)
                                                .foregroundColor(.clear)
                                                .frame(width: UIScreen.main.bounds.width/4, height: 34)
                                                .overlay{
                                                    // Date picker atau data date dari SwiftData as an interface biar bisa dipake buat filtering si card perbulannya
                                                    // dummy month
                                                    HStack(spacing:5){
                                                        Text("July 9,")
                                                        Text("2024")
                                                    }
                                                    .font(.system(size: 16, weight: .semibold))
                                                }
                                        }
                                        Spacer()
                                        
                                    }
                                    .padding([.top, .trailing])
                                }
                                .foregroundColor(.textColor2)
                                .background(Image(.cardBackground2))
                            }
                        
                        HStack(spacing:12){
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.containerColor4)
                                .frame(height: UIScreen.main.bounds.height/10)
                                .overlay{
                                    VStack(alignment: .leading){
                                        HStack(spacing:4){
                                            Image(systemName: "doc.plaintext.fill")
                                                .font(.system(size: 16, weight: .semibold))
                                            Text("Tax")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.textColor6)
                                            Spacer()
                                        }
                                        // value total tax bulan itu
                                        Text("Rp 108.900")
                                            .font(.system(size: 20, weight: .semibold))
                                        // persen taxny "\(trip.tax)% VAT"
                                        Text("11% VAT")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.textColor6)
                                    }
                                    .padding()
                                    .foregroundColor(.textColor2)
                                }
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.containerColor4)
                                .frame(height: UIScreen.main.bounds.height/10)
                                .overlay{
                                    VStack(alignment: .leading){
                                        HStack(spacing:4){
                                            Image(systemName: "banknote.fill")
                                                .font(.system(size: 16, weight: .semibold))
                                            Text("Saved")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.textColor6)
                                            Spacer()
                                        }
                                        // value total discount bulan itu
                                        Text("Rp 99.000")
                                            .font(.system(size: 20, weight: .semibold))
                                        
                                    }
                                    .padding()
                                    .foregroundColor(.textColor2)
                                }
                        }
                        
                    }
                    
                    // My cart
                    VStack(spacing:12){
                        HStack {
                            Text("My Cart")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.textColor3)
                            Spacer()
                        }
                        
                        // ganti dari list data cart
//                        List {
//                            ForEach(viewModel.trips) { trip in
//                                NavigationLink(destination: CartView(trip: trip, viewModel: viewModel)){
//                                    HStack(spacing:12){
//                                        RoundedRectangle(cornerRadius: 6)
//                                            .frame(width: 48, height: 48)
//                                            .foregroundColor(.white)
//                                            .overlay{
//                                                Image(systemName: "cart.fill")
//                                                    .foregroundColor(.iconColor1)
//                                            }
//                                        
//                                        VStack(alignment:.leading){
//                                            Text(trip.storeName)
//                                                .font(.system(size: 16, weight: .semibold))
//                                                .foregroundColor(.textColor3)
//                                            Text(trip.date,
//                                                 format: Date.FormatStyle(date: .long, time: .none))
//                                                .font(.system(size: 12, weight: .regular))
//                                                .foregroundColor(.textColor4)
//                                        }
//                                        
//                                        Spacer()
//                                        
//                                        // ini total spend harusnya cuman blom ada di trip.
//                                        Text("Rp999.900")
//                                            .font(.system(size: 20, weight: .semibold))
//                                            .foregroundColor(.textColor3)
//                                    }
//                                }
//                            }
//                            .onDelete(perform: viewModel.deleteTrip)
//                            .listRowSeparator(.hidden)
//                            .padding()
//                            .background(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .foregroundColor(.containerColor2)
//                            )
//                            .frame(height: 64)
//                        }
//                        .frame(width: UIScreen.main.bounds.width)
//                        .listStyle(.plain)
                        
                        // kalo ga ada pake if conditional dari cart (nanti aja lah wkwk)
                        Spacer()
                        VStack(spacing:24){
                            Image(.noCart)
                                .frame(width: 131, height: 128)
                            VStack(spacing:8){
                                Text("Your cart is empty")
                                    .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.textColor3)
                                Text("Tap the \(Image(systemName: "plus.circle.fill")) button to add\na new item to your cart.")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.textColor4)
                            }
                        }
                        .multilineTextAlignment(.center)
                        Spacer()
                        
                        Spacer()
                    }
                    
                }
                .navigationTitle("Cart")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("")
                    }
                }
                .frame(width: UIScreen.main.bounds.width-32)
            }
            .accentColor(.buttonColor2)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.colorbackground1)
    }
}

#Preview {
    ShoppingCartPage()
}
