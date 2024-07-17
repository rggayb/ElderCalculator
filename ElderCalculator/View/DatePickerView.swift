//
//  DatePickerView.swift
//  ElderCalculator
//
//  Created by Vincent Saranang on 17/07/24.
//

import SwiftUI

struct DatePickerView: View {
    @ObservedObject var viewModel: ShoppingTripViewModel

    // Define months and dynamically generate years up to the current year
    private let months = Calendar.current.monthSymbols
    private let currentYear = Calendar.current.component(.year, from: Date())
    
    @State private var years: [Int]
    @State private var selectedMonthIndex: Int
    @State private var selectedYearIndex: Int
    
    init(viewModel: ShoppingTripViewModel) {
        self.viewModel = viewModel
        
        // Dynamically determine the range of years
        let currentComponents = Calendar.current.dateComponents([.month, .year], from: viewModel.selectedDate)
        let selectedYear = currentComponents.year!
        let selectedMonth = currentComponents.month!
        
        self._years = State(initialValue: Array(1990...self.currentYear))
        self._selectedMonthIndex = State(initialValue: selectedMonth - 1)
        self._selectedYearIndex = State(initialValue: selectedYear - 1990)
    }

    var body: some View {
        ZStack {
            VStack {
                Text("Select Month and Year")
                
                HStack {
                    Picker("Month", selection: $selectedMonthIndex) {
                        ForEach(0..<months.count, id: \.self) { index in
                            Text(self.months[index]).tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150)
                    .clipped()
                    .onChange(of: selectedMonthIndex) {
                        updateDate()
                    }
                    
                    Picker("Year", selection: $selectedYearIndex) {
                        ForEach(0..<years.count, id: \.self) { index in
                            Text(String(self.years[index])).tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150)
                    .clipped()
                    .onChange(of: selectedYearIndex) {
                        updateDate()
                    }
                }
            }
        }
        .padding()
        .edgesIgnoringSafeArea(.all)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width+32)
        .background(.colorBackground2)
    }
    
    private func updateDate() {
        let selectedYear = years[selectedYearIndex]
        let selectedMonth = months[selectedMonthIndex]
        let dateString = "\(selectedMonth) \(selectedYear)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        
        if let newDate = formatter.date(from: dateString) {
            viewModel.selectedDate = newDate
            viewModel.calculateTotalsForSelectedMonth()
        }
    }
}
