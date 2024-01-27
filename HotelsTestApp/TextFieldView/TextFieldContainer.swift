//
//  TextFieldContainer.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 11.01.2024.
//

import SwiftUI

struct TextFieldContainer: UIViewRepresentable {
    @Binding var textIsValid: Bool 
    @Binding var text: String
    @Binding var isFirstResponder: Bool {
        didSet {
            print("Container isFirstResponder = \(isFirstResponder)")
        }
    }
    
    let fieldFormat: FieldFormat
    var placeholder: String
    
    func makeCoordinator() -> TextFieldCoordinator {
        TextFieldCoordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TextFieldContainer>) -> UITextField {
        let innerTextField = UITextField(frame: .zero)
        innerTextField.placeholder = placeholder
        innerTextField.text = text
        innerTextField.delegate = context.coordinator
        
        switch fieldFormat {
            case .phoneNumber:
            innerTextField.keyboardType = .phonePad
        case .string:
            innerTextField.keyboardType = .default
        case .number:
            innerTextField.keyboardType = .numberPad
        case .email:
            innerTextField.keyboardType = .emailAddress
        }

        context.coordinator.setup(innerTextField)
                
        return innerTextField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldContainer>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        
        switch isFirstResponder {
        case true:
            DispatchQueue.main.async {
                uiView.becomeFirstResponder()
            }
        case false:
            DispatchQueue.main.async {
                uiView.resignFirstResponder()
            }
        }
        
        context.coordinator.updateParent(self)
    }
}
