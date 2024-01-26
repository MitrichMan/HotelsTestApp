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
    
    let fieldFormat: FieldFormat
    var placeholder: String
    var isFirstResponder: Bool
    
//    init(
//        placeholder: String,
//        text: String,
//        fieldFormat: FieldFormat,
//        isFirstResponder: Bool,
//        textIsValid: Bool
//    ) {
//        self.placeholder = placeholder
//        self.text = text
//        self.fieldFormat = fieldFormat
//        self.isFirstResponder = isFirstResponder
//        self.textIsValid = textIsValid
//    }
    
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
        case true: uiView.becomeFirstResponder()
        case false: uiView.resignFirstResponder()
        }
        
        context.coordinator.updateParent(self)
    }
}
