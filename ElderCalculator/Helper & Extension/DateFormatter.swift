//
//  DateFormatter.swift
//  ElderCalculator
//
//  Created by Michelle Chau on 17/07/24.
//

import Foundation

extension DateFormatter {
    static let monthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
}
