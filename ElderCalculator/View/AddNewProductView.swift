//
//  AddNewProduct.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 09/07/24.
//

import SwiftUI
import SwiftData

struct AddNewProductView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var trip: Trip
    
    @ObservedObject var viewModel: ShoppingTripViewModel
    @StateObject var productViewModel = ProductViewModel()
    
    let categories: [String] = ["Fruit", "Vegetable", "Dairy", "Meat"]
    
    @State var showAlert: Bool = false
    var alertMessage: String = "Adding this product will exceed your budget. Do you want to proceed?"

    
    var body: some View {
        // full background
        ZStack {
            VStack(spacing:32){
                // Headline
//                HStack{
                    // ganti variable nama toko pake binding maybe?
                    Text("Add New Item")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.textColor1)
//                    Spacer()
//                }
                // Shopping trip + container
                VStack(spacing:16){
                    // Inside Container
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: UIScreen.main.bounds.height/8)
                        .overlay{
                            ZStack {
                                // detail container
                                VStack{
                                    HStack {
                                        VStack(alignment: .leading){
                                            Text("Total price")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.textColor6)
                                            // value total expense bulan itu
                                            Text("Rp \((productViewModel.totalPrice), specifier: "%.0f")")
                                                .font(.system(size: 32, weight: .bold))
                                                .foregroundStyle(.textColor2)
                                            // value "bugget left" = "budget left gede" - "total price itu"
                                            Text("Rp ... Budget Left")
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundStyle(.textColor2)
                                        }
                                        Spacer()
                                    }
                                }
                                .padding()
                                
                                // jumlah item
                                VStack {
                                    HStack {
                                        Spacer()
                                        RoundedRectangle(cornerRadius: 6)
                                            .foregroundColor(.clear)
                                            .frame(width: UIScreen.main.bounds.width/2.6, height: 34)
                                            .overlay{
                                                HStack(spacing:8){
                                                    Text("... Item in Cart")
                                                    Image(systemName: "cart.fill.badge.plus")
                                                }
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.textColor6)
                                            }
                                    }
                                    Spacer()
                                    
                                }
                                .padding([.top, .trailing])
                            }
                            .foregroundColor(.textColor2)
                            .background(Image(.cardBackground2).resizable())
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
                                            .foregroundColor(.textColor6)
                                        Spacer()
                                    }
                                    Text("\(productViewModel.totalTax, specifier: "%.0f")")
                                        .font(.system(size: 20, weight: .semibold))
                                    // butuh operan persen taxnya
                                    Text("...% VAT")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.textColor6)
                                }
                                .padding()
                                .foregroundColor(.textColor2)
                                .background(Image(.cardBackground3).resizable())
                            }
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: UIScreen.main.bounds.height/10)
                            .overlay{
                                VStack(alignment: .leading){
                                    Spacer()
                                    HStack(spacing:4){
                                        Image(systemName: "banknote.fill")
                                            .font(.system(size: 16, weight: .semibold))
                                        Text("Saved")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.textColor6)
                                        Spacer()
                                    }
                                    Text("Rp \(productViewModel.totalDiscount, specifier: "%.0f")")
                                        .font(.system(size: 20, weight: .semibold))
                                    Spacer()
                                }
                                .padding()
                                .foregroundColor(.textColor2)
                                .background(Image(.cardBackground3).resizable())
                            }
                    }
                }
                
                // Fill box
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width-32 ,height: 44)
                    .foregroundColor(.containerColor3)
                    .overlay{
                        HStack{
                            Text("Product Name")
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            Picker("Select Product", selection: $productViewModel.name) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category).tag(category)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding()
                    }
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width-32, height: 132)
                    .foregroundColor(.containerColor3)
                    .overlay{
                        VStack{
                            HStack{
                                Text("Price (Rp)")
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                                TextField("0", text: $productViewModel.price)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                    .font(.system(size: 16, weight: .regular))
                            }
                            Divider()
                            HStack{
                                Text("Discount")
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                                HStack(spacing:8){
                                    TextField("0", text: $productViewModel.discount)
                                        .keyboardType(.numberPad)
                                        .font(.system(size: 16, weight: .regular))
                                    Text("% Off")
                                        .font(.system(size: 16, weight: .regular))
                                }
                                .multilineTextAlignment(.trailing)
                                
                            }
                            Divider()
                            HStack{
                                Text("Quantity")
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                                TextField("0", text: $productViewModel.quantity)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                    .font(.system(size: 16, weight: .regular))
                                
                            }
                        }
                        .padding()
                    }
                
                Spacer()
                
                Button (action: {                    
                    //check if product price exceed budget or not
                    if productViewModel.isNotExceedBudget(trip: trip) {
                        viewModel.addNewProduct(
                            name: productViewModel.name,
                            price: Double(productViewModel.price) ?? 0,
                            quantity: Int(productViewModel.quantity) ?? 0,
                            discount: Int(productViewModel.discount) ?? 0,
                            totalPrice: productViewModel.totalPrice,
                            trip: trip)
                        
                        //add pop up for product saved
                        
//                        dismiss()
                        AddItemSound.shared.playSound(named: "ScanSound")
                        AddItemSound.shared.triggerHapticFeedback()
                    } else {
                        //show alert if product price exceed budget
                        showAlert = true
                    }
                    viewModel.calculateTotals()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                    // kalo valid
                        .foregroundColor(.iconColor1)
                    // blm valid
//                        .foregroundColor(.containerColor1.opacity(4/3))
                        .overlay{
                            // validasi
                            Text("Save")
                                .font(.system(size: 20, weight: .bold))
                            // klo valid
                                .foregroundColor(.textColor2)
                            // blm valid
//                                .foregroundColor(.textColor5)
                                .padding()
                        }
                }
            }
            .onAppear {
                productViewModel.taxRate = trip.tax
            }
            .alert("Budget Exceeded", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Continue", role: .destructive) {
                    viewModel.addNewProduct(
                        name: productViewModel.name,
                        price: Double(productViewModel.price) ?? 0,
                        quantity: Int(productViewModel.quantity) ?? 0,
                        discount: Int(productViewModel.discount) ?? 0,
                        totalPrice: productViewModel.totalPrice,
                        trip: trip
                    )
                    viewModel.calculateTotals()
                    AddItemSound.shared.playSound(named: "ScanSound")
                    AddItemSound.shared.triggerHapticFeedback()
                    dismiss()
                }
            } message: {
                Text(alertMessage)
            }

            
            .frame(width: UIScreen.main.bounds.width-32)
            .padding(.vertical, 48)
        }
        .background(.colorBackground2)
        .frame(width: UIScreen.main.bounds.width)
    }
}


