//
//  DetailProductView.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 16/07/24.
//

import SwiftUI

struct DetailProductView: View {
    @Bindable var trip: Trip
    @Bindable var product: Product
    @ObservedObject var productDetailViewModel: ProductDetailViewModel
    
    var body: some View {
        VStack(spacing:16){
            VStack(spacing:8){
                VStack{
                    HStack{
                        Text("Total Price")
                            .font(.system(size: 16, weight: .regular))
                        Spacer()
                    }
                    HStack{
                        Text("\(productDetailViewModel.totalPrice, specifier: "%.0f")")
                            .font(.system(size: 32, weight: .bold))
                        Spacer()
                    }
                }
                .foregroundColor(.textColor3)
                
                VStack(alignment:.leading, spacing: 4){
                    HStack(spacing:8){
                        Image(systemName: "basket.fill")
                        Text("\(product.name)")
                        Spacer()
                    }
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.textColor3)
                    
                    Text("\(trip.date, format: Date.FormatStyle(date: .long, time: .none))")
                        .foregroundColor(.textColor4)
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 88)
                .foregroundColor(.containerColor3)
                .overlay{
                    VStack{
                        HStack{
                            Text("Price")
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            Text("\(product.price, specifier: "%.0f")")
                                .font(.system(size: 16, weight: .regular))
                        }
                        Divider()
                        HStack{
                            Text("Quantity")
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            Text("\(product.quantity)")
                                .font(.system(size: 16, weight: .regular))
                        }
                    }
                    .foregroundColor(.textColor3)
                    .padding()
                }
            
            HStack(spacing:12){
                RoundedRectangle(cornerRadius: 6)
                    .frame(height: 80)
                    .foregroundColor(.containerColor3)
                    .overlay{
                        HStack{
                            VStack(alignment:.leading){
                                Text("Tax (\(trip.tax)% VAT)")
                                    .foregroundColor(.textColor4)
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Rp \(productDetailViewModel.totalTax, specifier: "%.0f")")
                                    .foregroundColor(.textColor3)
                                    .font(.system(size: 20, weight: .semibold))
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
                RoundedRectangle(cornerRadius: 6)
                    .frame(height: 80)
                    .foregroundColor(.containerColor3)
                    .overlay{
                        HStack{
                            VStack(alignment:.leading){
                                Text("Saved (\(product.discount)% VAT)")
                                    .foregroundColor(.textColor4)
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Rp \(productDetailViewModel.totalDiscount, specifier: "%.0f")")
                                    .foregroundColor(.textColor3)
                                    .font(.system(size: 20, weight: .semibold))
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
            }
        }
        .padding()
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        .background(.colorBackground2)
    }
}
