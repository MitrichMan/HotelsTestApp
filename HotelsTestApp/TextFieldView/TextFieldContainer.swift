//
//  TextFieldContainer.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 11.01.2024.
//

import SwiftUI

struct TextFieldContainer: UIViewRepresentable {
    var text: String
    let fieldFormat: FieldFormat
    var placeholder: String
    
    init(
        placeholder: String,
        text: String,
        fieldFormat: FieldFormat
    ) {
        self.placeholder = placeholder
        self.text = text
        self.fieldFormat = fieldFormat
    }
    
    func makeCoordinator() -> TextFieldCoordinator {
        TextFieldCoordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TextFieldContainer>) -> UITextField {
        let innerTextField = UITextField(frame: .zero)
        innerTextField.placeholder = placeholder
        innerTextField.text = text
        innerTextField.delegate = context.coordinator
        innerTextField.keyboardType = .phonePad
        
        context.coordinator.setup(innerTextField)
                
        return innerTextField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldContainer>) {
        uiView.text = self.text
        context.coordinator.updateParent(self)
    }
}
