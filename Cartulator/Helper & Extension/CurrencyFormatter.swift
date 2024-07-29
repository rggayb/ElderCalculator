//
//  CurrencyFormatter.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 25/07/24.
//

import Foundation

class CurrencyFormatter {
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter
    }()
    
    static func formatCurrency(value: Double) -> String {
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }

    static func getCurrencySymbol() -> String {
        return formatter.currencySymbol
    }
}
