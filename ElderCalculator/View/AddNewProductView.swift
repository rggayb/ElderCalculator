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
    @ObservedObject var cartViewModel: CartViewModel
    
    let categories: [String] = [
        NSLocalizedString("Choose item", comment: "picker"),
        NSLocalizedString("Fruit", comment: "picker"),
        NSLocalizedString("Vegetable", comment: "picker"),
        NSLocalizedString("Dairy", comment: "picker"),
        NSLocalizedString("Meat", comment: "picker"),
        NSLocalizedString("Noodles", comment: "picker"),
        NSLocalizedString("Seafood", comment: "picker"),
        NSLocalizedString("Soap", comment: "picker"),
        NSLocalizedString("Shampoo", comment: "picker"),
        NSLocalizedString("Soft Drink", comment: "picker")
    ]
    
    @State var showAlert: Bool = false
    var alertMessage: String = "Adding this product will exceed your budget. Do you want to proceed?"
    
    @State var showComplete: Bool = false
    
    var body: some View {
        // full background
        ZStack {
            VStack(spacing:32){
                // Headline
                //                HStack{
                // ganti variable nama toko pake binding maybe?
                Text("\(trip.storeName)")
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
                                            Text("Rp \(productViewModel.totalPrice, specifier: "%.0f")")
                                                .font(.system(size: 32, weight: .bold))
                                                .foregroundStyle(.textColor2)
                                            // value "bugget left" = "budget left gede" - "total price itu"
                                            Text("Rp \(cartViewModel.budgetLeft, specifier: "%.0f") Budget Left")
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundStyle(.textColor3)
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
                                                    Text("\(cartViewModel.totalItem) Item in Cart")
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
                                        Spacer()
                                    }
                                    .foregroundColor(.textColor6)
                                    Text("\(productViewModel.totalTax, specifier: "%.0f")")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundStyle(.textColor3)
                                    // butuh operan persen taxnya
                                    Text("\(trip.tax)% VAT")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.textColor6)
                                }
                                .padding()
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
                                        Spacer()
                                    }
                                    .foregroundColor(.textColor6)
                                    Text("Rp \(productViewModel.totalDiscount, specifier: "%.0f")")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundStyle(.textColor3)
                                    Spacer()
                                }
                                .padding()
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
                                    TextFieldWithDoneButton(text: $productViewModel.discount, placeholder: "0", alignment: .right)
                                        .font(.system(size: 16, weight: .regular))
                                    Text("% Off")
                                        .font(.system(size: 16, weight: .regular))
                                }
                                .multilineTextAlignment(.trailing)
                                
                            }
                            .padding(.vertical, 2)
                            Divider()
                            HStack{
                                Text("Quantity")
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                                TextField("1", text: $productViewModel.quantity)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                    .font(.system(size: 16, weight: .regular))
                                
                            }
                        }
                        .padding()
                    }
                
                Spacer()
                
                Button(action: {
                    // Check if the product price exceeds the budget or not
                    if productViewModel.isNotExceedBudget(trip: trip) {
                        
                        //check if category selecte is "choose item", change it to "Product"
                        productViewModel.checkSelectedCategory()
                        
                        //add product
                        viewModel.addNewProduct(
                            name: productViewModel.name,
                            price: Double(productViewModel.price) ?? 0,
                            quantity: Int(productViewModel.quantity) ?? 1,
                            discount: Int(productViewModel.discount) ?? 0,
                            totalPrice: productViewModel.totalPrice,
                            trip: trip
                        )
                        
                        // change date to now
                        viewModel.selectedDate = Date()
                        // recalculate card for selected month
                        viewModel.calculateTotalsForSelectedMonth()
                        
                        // Play sound and haptic feedback
                        AddItemSound.shared.playSound(named: "ScanSound")
                        AddItemSound.shared.triggerHapticFeedback()
                        
                        // Show the complete popup
                        showComplete = true
                        
                        // Delay the reset and dismiss of the popup
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { // Adjust time as needed
                            showComplete = false
                            productViewModel.resetProductForm()
                        }
                        
                        viewModel.calculateTotalsForSelectedMonth()
                    } else {
                        // Play sound and haptic feedback
                        AddItemSound.shared.playSound(named: "WarningSound")
                        AddItemSound.shared.triggerHapticFeedback()
                        showAlert = true
                    }
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .foregroundColor(productViewModel.isProductValid() ? .iconColor1 : .containerColor1.opacity(4/3))
                        .overlay {
                            Text("Add to Cart")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(productViewModel.isProductValid() ? .textColor7 : .textColor5)
                        }
                }
                .disabled(!productViewModel.isProductValid() || showComplete)
            }
            .onAppear {
                productViewModel.taxRate = trip.tax
            }
            .alert("Budget Exceeded", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Continue", role: .destructive) {
                    
                    //check if category selecte is "choose item", change it to "Product"
                    productViewModel.checkSelectedCategory()
                    
                    //add product
                    viewModel.addNewProduct(
                        name: productViewModel.name,
                        price: Double(productViewModel.price) ?? 0,
                        quantity: Int(productViewModel.quantity) ?? 1,
                        discount: Int(productViewModel.discount) ?? 0,
                        totalPrice: productViewModel.totalPrice,
                        trip: trip
                    )
                    
                    // change date to now
                    viewModel.selectedDate = Date()
                    
                    // recalculate card for selected month
                    viewModel.calculateTotalsForSelectedMonth()
                    
                    AddItemSound.shared.playSound(named: "ScanSound")
                    AddItemSound.shared.triggerHapticFeedback()
                    dismiss()
                }
            } message: {
                Text(alertMessage)
            }
            .frame(width: UIScreen.main.bounds.width-32)
            .padding(.vertical, 48)
            if showComplete{
                ZStack{
                    Color.black.opacity(0.2).edgesIgnoringSafeArea(.all)
                    VStack{
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 72))
                            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: 1)
                        Text("Added")
                            .font(.system(size: 28, weight: .regular))
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.colorBackground2)
    }
}
