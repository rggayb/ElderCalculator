//
//  MonthYearPicker.swift
//  ElderCalculator
//
//  Created by James Cellars on 16/07/24.
//

import SwiftUI

struct MonthYearPicker: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        HStack {
            Spacer()
            
            Picker("Month", selection: $selectedDate) {
                ForEach(1..<13) { month in
                    Text(DateFormatter().monthSymbols[ month - 1]).tag(month)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectedDate, perform: { value in
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month], from: selectedDate)
                if let newDate = calendar.date(from: components) {
                    selectedDate = newDate
                }
            })
            
            Picker("Year", selection: $selectedDate) {
                ForEach(2020..<2031) { year in
                    Text("\(year)").tag(year)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectedDate, perform: { value in
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month], from: selectedDate)
                if let newDate = calendar.date(from: components) {
                    selectedDate = newDate
                }
            })
            Spacer()
        }
    }
}
