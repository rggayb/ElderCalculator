//
//  TextFieldWithDoneButton.swift
//  ElderCalculator
//
//  Created by Vincent Saranang on 17/07/24.
//

import SwiftUI

struct TextFieldWithDoneButton: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var alignment: NSTextAlignment = .left
    var keyboardType: UIKeyboardType = .decimalPad
    var shouldFormatNumber: Bool = false

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldWithDoneButton

        init(parent: TextFieldWithDoneButton) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            let newText = textField.text ?? ""
            let formattedText = parent.shouldFormatNumber ? NumberFormatterHelper.formatNumber(newText) : newText
            if formattedText != newText {
                textField.text = formattedText
            }
            parent.text = formattedText
        }

        @objc func doneButtonTapped() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.textAlignment = alignment
        textField.keyboardType = keyboardType
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(Coordinator.doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: false)
        textField.inputAccessoryView = toolbar

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}
