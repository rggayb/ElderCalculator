//
//  Home.swift
//  ElderCalculator
//
//  Created by James Cellars on 09/07/24.
//

import SwiftUI

struct Home: View {
    
    @State var displayValue = "0"
    @State var computeValue = 0.0
    @State var currentOperator: Operation = .none
    @State var isTaxIncluded = false
    
    let taxPercentage = 0.11
    
    //Buttons
    let buttons: [[CalculatorButtons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                //Tax toggle
                TaxToggle(isTaxIncluded: $isTaxIncluded)
                
                //MARK: Display
                Spacer()
                HStack {
                    Spacer()
                    
                    Text("\(displayValue)")
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.black)
                }
                .padding()
                
                //MARK: Buttons
                ForEach(buttons, id: \.self) { row in
                    
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button {
                                self.didTap(button: item)
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .clipShape(.rect(cornerRadius: self.buttonWidth(item: item) / 2))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    //Button width
    func buttonWidth(item: CalculatorButtons) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    //Button height
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    //Format display value
    func formatDisplayValue(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
    
    //MARK: DidTap function
    func didTap(button: CalculatorButtons) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperator = .add
                self.computeValue = Double(self.displayValue) ?? 0
            } else if button == .subtract {
                self.currentOperator = .subtract
                self.computeValue = Double(self.displayValue) ?? 0
            } else if button == .divide {
                self.currentOperator = .divide
                self.computeValue = Double(self.displayValue) ?? 0
            } else if button == .multiply {
                self.currentOperator = .multiply
                self.computeValue = Double(self.displayValue) ?? 0
            } else if button == .equal {
                let runningValue = self.computeValue
                let currentValue = Double(self.displayValue) ?? 0
                var result: Double
                
                switch self.currentOperator {
                case .add:
                    result = runningValue + currentValue
                case .subtract:
                    result = runningValue - currentValue
                case .divide:
                    result = runningValue / currentValue
                case .multiply:
                    result = runningValue * currentValue
                case .none:
                    result = currentValue
                }
                
                //Includes tax addition if toggle is on
                if self.isTaxIncluded {
                    result += result * taxPercentage
                }
                self.displayValue = self.formatDisplayValue(result)
            }
            
            if button != .equal {
                self.displayValue = "0"
            }
        case .clear:
            self.displayValue = "0"
        case .decimal:
            if !self.displayValue.contains(".") {
                self.displayValue += "."
            }
        case .negative:
            if self.displayValue != "0" {
                if self.displayValue.contains("-") {
                    self.displayValue.remove(at: self.displayValue.startIndex)
                } else {
                    self.displayValue = "-" + self.displayValue
                }
            }
        case .percent:
            if let value = Double(self.displayValue) {
                self.displayValue = "\(value / 100)"
            }
        default:
            let number = button.rawValue
            if self.displayValue == "0" {
                displayValue = number
            } else {
                self.displayValue = "\(self.displayValue)\(number)"
            }
        }
    }
}

#Preview {
    Home()
}
