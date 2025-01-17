//
//  ShoppingCartPageView.swift
//  ElderCalculator
//
//  Created by Vincent Saranang on 13/07/24.
//

import SwiftUI

struct ShoppingCartPageView: View {
    @State private var isAddNewProductPresented: Bool = false
    @State private var isEditTripPresented: Bool = false
    
    @Bindable var trip: Trip
    
    @ObservedObject var viewModel: ShoppingTripViewModel
    @ObservedObject var cartViewModel: CartViewModel
    
    @State private var selectedProduct: Product?
    
    var body: some View {
        // full background
        ZStack {
            NavigationView{
                VStack(spacing:32){
                    // Shopping trip + container
                    VStack(spacing:16){
                        // Label & button action
                        HStack{
                            Text("\(trip.storeName)")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.textColor1)
                            Spacer()
                            // Edit Trips
                            Button(action: {
                                viewModel.storeName = trip.storeName
                                viewModel.budget = NumberFormatterHelper.formatNumber(String(Int(trip.budget)))
                                viewModel.tax = String(trip.tax)
                                isEditTripPresented.toggle()
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(.buttonColor1)
                            }
                            .sheet(isPresented: $isEditTripPresented, content: {
                                UpdateTripView(trip: trip, viewModel: viewModel)
                                    .presentationDragIndicator(.visible)
                            })
                            
                            // Add cart
                            Button(action: {
                                isAddNewProductPresented.toggle()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(.buttonColor1)
                            }
                            .sheet(isPresented: $isAddNewProductPresented) {
                                AddNewProductView(trip: trip, viewModel: viewModel, cartViewModel: cartViewModel)
                                    .presentationDragIndicator(.visible)
                            }
                            
                        }
                        
                        // Inside Container
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: UIScreen.main.bounds.height/6)
                            .overlay{
                                ZStack {
                                    VStack{
                                        HStack {
                                            VStack(alignment: .leading, spacing: 8){
                                                Text("Total Expense")
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundColor(.textColor3)
                                                Text("\(CurrencyFormatter.formatCurrency(value: cartViewModel.totalExpense))")
                                                    .font(.system(size: 32, weight: .bold))
                                                    .foregroundColor(cartViewModel.isExceedBudget() ? .textColor8 : .textColor2)
                                                Divider()
                                                Text(cartViewModel.isExceedBudget() ? "\(CurrencyFormatter.formatCurrency(value: (abs(cartViewModel.budgetLeft)))) Budget Exceeded" : " \(CurrencyFormatter.formatCurrency(value: cartViewModel.budgetLeft)) Budget Left")
                                                    .font(.system(size: 16, weight: .regular))
                                                    .foregroundStyle(.textColor1)
                                                    
                                            }
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                    
                                    // date
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Text("\(cartViewModel.trip.date, format: Date.FormatStyle(date: .long, time: .none))")
                                                .foregroundColor(.textColor3)
                                                .font(.system(size: 16, weight: .semibold))
                                                .padding(8)
                                                .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.clear))
                                        }
                                        Spacer()
                                        
                                    }
                                    .padding([.top, .trailing])
                                }
                                .background(cartViewModel.isExceedBudget() ? Image(.cardBackground4).resizable() : Image(.cardBackground2).resizable())
                            }
                        
                        HStack(spacing:12){
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: UIScreen.main.bounds.height/10)
                                .overlay{
                                    VStack(alignment: .leading){
                                        HStack(spacing:4){
                                            Image(systemName: "doc.plaintext.fill")
                                                .font(.system(size: 16, weight: .semibold))
                                            Text("Tax")
                                                .font(.system(size: 16, weight: .semibold))
                                            Spacer()
                                        }
                                        .foregroundColor(.textColor4)
                                        Text("\(CurrencyFormatter.formatCurrency(value: cartViewModel.totalTripTax))")
                                            .foregroundStyle(.textColor1)
                                            .font(.system(size: 20, weight: .semibold))
                                        Text("\(trip.tax)% VAT")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.textColor4)
                                    }
                                    .padding()
                                    .foregroundColor(.textColor2)
                                    .background(Image(.cardBackground3).resizable())
                                }
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: UIScreen.main.bounds.height/10)
                                .overlay{
                                    VStack(alignment: .leading){
                                        HStack(spacing:4){
                                            Image(systemName: "banknote.fill")
                                                .font(.system(size: 16, weight: .semibold))
                                            Text("Saved")
                                                .font(.system(size: 16, weight: .semibold))
                                            Spacer()
                                        }
                                        .foregroundColor(.textColor4)
                                        Text("\(CurrencyFormatter.formatCurrency(value: cartViewModel.totalTripDiscount))")
                                            .foregroundStyle(.textColor1)
                                            .font(.system(size: 20, weight: .semibold))
                                        Text("")
                                            .font(.system(size: 12, weight: .semibold))
                                    }
                                    .padding()
                                    .foregroundColor(.textColor2)
                                    .background(Image(.cardBackground3).resizable())
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
                        
                        if trip.products.isEmpty {
                            Spacer()
                            Button(action:{
                                isAddNewProductPresented.toggle()
                            }){
                                VStack(spacing:24){
                                    Image(.noCart)
                                        .opacity(0.5)
                                    VStack(spacing:8){
                                        Text("Your cart is empty")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.textColor3)
                                        Text("Tap the \(Image(systemName: "plus.circle.fill")) button to add a new item to your cart.")
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(.textColor4)
                                    }
                                    .frame(width: UIScreen.main.bounds.width/2)
                                }
                                .multilineTextAlignment(.center)
                            }
                            .sheet(isPresented: $isAddNewProductPresented) {
                                AddNewProductView(trip: trip, viewModel: viewModel, cartViewModel: cartViewModel)
                                    .presentationDragIndicator(.visible)
                            }
                            Spacer()
                        } else {
                            List{
                                ForEach(trip.products) { product in
                                    VStack {
                                        HStack(spacing:12){
                                            RoundedRectangle(cornerRadius: 6)
                                                .frame(width: 48, height: 48)
                                                .foregroundColor(.white)
                                                .overlay{
                                                    Image(product.imageName)
                                                        .resizable()
                                                        .frame(width: 30, height: 30, alignment: .center)
                                                        .foregroundColor(.iconColor1)
                                                }
                                            
                                            VStack(alignment:.leading){
                                                Text("\(NSLocalizedString(product.name, comment: "productName"))")
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundColor(.textColor3)
                                                Text("\(product.quantity) Qty")
                                                    .font(.system(size: 12, weight: .regular))
                                                    .foregroundColor(.textColor4)
                                            }
                                            
                                            Spacer()
                                            
                                            let productDetail = ProductDetailViewModel(product: product, trip: trip)
                                            
                                            Text("\(CurrencyFormatter.formatCurrency(value: productDetail.totalPrice))")
                                                .font(.system(size: 20, weight: .semibold))
                                                .foregroundColor(.textColor3)
                                        }
                                        .listRowSeparator(.hidden)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(.containerColor2)
                                        )
                                        .frame(height: 64)
                                    }
                                    .onTapGesture {
                                        selectedProduct = product
                                    }
                                    .sheet(item: $selectedProduct) { selectedProduct in
                                        let productDetailViewModel = ProductDetailViewModel(product: selectedProduct, trip: trip)
                                        DetailProductView(trip: trip, product: selectedProduct, productDetailViewModel: productDetailViewModel)
                                            .presentationDetents([.height(UIScreen.main.bounds.width)])
                                            .presentationDragIndicator(.visible)
                                    }
                                }
                                .onDelete(perform: {
                                    indexes in viewModel.deleteProduct(indexes: indexes, from: trip)
                                    // change date to now
                                    viewModel.selectedDate = Date()
                                    // recalculate card for selected month
                                    viewModel.calculateTotalsForSelectedMonth()
                                })
                                .listRowSeparator(.hidden)
                                .navigationTitle("Cart")
                            }
                            .frame(width: UIScreen.main.bounds.width)
                            .listStyle(.plain)

                        }
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
                .toolbar(.hidden)
                .frame(width: UIScreen.main.bounds.width-32)
            }
            .accentColor(.buttonColor2)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.colorbackground1)
    }
}
