//
//  ItemList_Preview.swift
//  ElderCalculator
//
//  Created by Rangga Yudhistira Brata on 14/07/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, visionOS 1.0, watchOS 10.0, *)
struct ItemList_Preview: PreviewProvider {
    static var previews: some View {
        let sampleTrip = Trip(date: Date(), storeName: "Test Store", budget: 100, tax: 10)
        let viewModel = HomeViewModel(trip: sampleTrip)
        ItemList(viewModel: viewModel)
    }
}

