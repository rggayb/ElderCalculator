//
//  NumberFormatterHelper.swift
//  ElderCalculator
//
//  Created by Vincent Saranang on 24/07/24.
//

import Foundation

class NumberFormatterHelper {
    static func formatNumber(_ number: String) -> String {
        let cleanNumber = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        guard let numberValue = Int(cleanNumber) else { return number }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: numberValue)) ?? number
    }
}
