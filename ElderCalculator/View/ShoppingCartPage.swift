////
////  ShoppingCartPage.swift
////  ElderCalculator
////
////  Created by Vincent Saranang on 13/07/24.
////
//
//import SwiftUI
//
//struct ShoppingCartPage: View {
//    @State private var isAddNewTripPresented: Bool = false
//    @StateObject var viewModel = ShoppingTripViewModel(inMemory: false)
//    
//    var body: some View {
//        // full background
//        ZStack {
//            NavigationView{
//                VStack(spacing:32){
//                    // Shopping trip + container
//                    VStack(spacing:24){
//                        // Label & button action
//                        HStack{
//                            Text("Shopping Trip")
//                                .font(.system(size: 32, weight: .bold))
//                                .foregroundColor(.textColor1)
//                            Spacer()
//                            // Add trips
//                            Button(action: {
//                                isAddNewTripPresented.toggle()
//                            }) {
//                                Image(systemName: "plus.circle.fill")
//                                    .font(.system(size: 36))
//                                    .foregroundColor(.buttonColor1)
//                            }
//                            .sheet(isPresented: $isAddNewTripPresented) {
//                                AddNewTripView(viewModel: viewModel)
//                            }
//                        }
//                        
//                        // Inside Container
//                        // buat bisa di click, tinggal button buat pop ganti tanggal atau kalo mau diganti by chevron kiri kanan atau slider jg bisa
//                        RoundedRectangle(cornerRadius: 10)
//                            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                            .frame(height: UIScreen.main.bounds.height/4)
//                            .overlay{
//                                ZStack {
//                                    // detail container
//                                    VStack{
//                                        HStack {
//                                            VStack(alignment: .leading, spacing: 8){
//                                                Text("Total Expense")
//                                                    .font(.system(size: 20, weight: .semibold))
//                                                // value total expense bulan itu
//                                                Text("Rp 999.900")
//                                                    .font(.system(size: 40, weight: .bold))
//                                            }
//                                            Spacer()
//                                        }
//                                        
//                                        Spacer()
//                                        
//                                        HStack{
//                                            VStack(alignment: .leading){
//                                                HStack(spacing:4){
//                                                    Image(systemName: "doc.plaintext.fill")
//                                                        .font(.system(size: 16, weight: .semibold))
//                                                    Text("Tax")
//                                                        .font(.system(size: 16, weight: .semibold))
//                                                }
//                                                // value total tax bulan itu
//                                                Text("Rp 108.900")
//                                                    .font(.system(size: 20, weight: .semibold))
//                                            }
//                                            Spacer()
//                                            VStack(alignment: .leading){
//                                                HStack(spacing:4){
//                                                    Image(systemName: "banknote.fill")
//                                                        .font(.system(size: 16, weight: .semibold))
//                                                    Text("Saved")
//                                                        .font(.system(size: 16, weight: .semibold))
//                                                }
//                                                // value total discount bulan itu
//                                                Text("Rp 99.000")
//                                                    .font(.system(size: 20, weight: .semibold))
//                                            }
//                                        }
//                                    }
//                                    
//                                    .padding()
//                                    
//                                    // date
//                                    VStack {
//                                        HStack {
//                                            Spacer()
//                                            
//                                            RoundedRectangle(cornerRadius: 6)
//                                                .foregroundColor(.containerColor1)
//                                                .frame(width: UIScreen.main.bounds.width/4, height: 34)
//                                                .overlay{
//                                                    // Date picker atau data date dari SwiftData as an interface biar bisa dipake buat filtering si card perbulannya
//                                                    // dummy month
//                                                    HStack(spacing:5){
//                                                        Text("July")
//                                                        Text("2024")
//                                                    }
//                                                    .font(.system(size: 16, weight: .semibold))
//                                                }
//                                        }
//                                        Spacer()
//                                        
//                                    }
//                                    .padding([.top, .trailing])
//                                }
//                                .foregroundColor(.textColor2)
//                                .background(Image(.cardBackground1))
//                            }
//                        
//                    }
//                    
//                    // Recent trip
//                    VStack(spacing:12){
//                        HStack {
//                            Text("Recent Trip")
//                                .font(.system(size: 20, weight: .semibold))
//                                .foregroundColor(.textColor3)
//                            Spacer()
//                        }
//                        
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
//                        
//                        // kalo ga ada pake if conditional dari trip (nanti aja lah wkwk)
////                        Spacer()
////                        VStack(spacing:24){
////                            Image(.noTrip)
////                                .frame(width: 131, height: 128)
////                            VStack(spacing:8){
////                                Text("No Trips Yet?")
////                                    .font(.system(size: 20, weight: .bold))
////                                .foregroundColor(.textColor3)
////                                Text("Tap the 􀁍 button to add\na new trip to your list.")
////                                    .font(.system(size: 16, weight: .regular))
////                                    .foregroundColor(.textColor4)
////                            }
////                        }
////                        .multilineTextAlignment(.center)
////                        Spacer()
//                        
//                        Spacer()
//                    }
//                    
//                }
//                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
//                .frame(width: UIScreen.main.bounds.width-32)
//            }
//        }
//        .frame(width: UIScreen.main.bounds.width)
//        .background(.colorbackground1)
//    }
//}
//
//#Preview {
//    ShoppingCartPage()
//}
