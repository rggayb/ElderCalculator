//
//  NumberFormatter.swift
//  ElderCalculator
//
//  Created by James Cellars on 16/07/24.
//

import Foundation

extension NumberFormatter {
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        return formatter
    }()
}
