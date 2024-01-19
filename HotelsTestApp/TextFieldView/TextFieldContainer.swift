//
//  TextFieldContainer.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 11.01.2024.
//

import SwiftUI

struct TextFieldContainer: UIViewRepresentable {
    var text: String

    private var placeholder: String
    
    init(
        placeholder: String,
        text: String
    ) {
        self.placeholder = placeholder
        self.text = text
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
        
        
        
//        //Setting the cursor at the right place
        
//        var cursorLocation = 0 {
//            didSet {
//                switch text.count {
//                case 0...1:
//                    cursorLocation = text.count + 1
//                case 2...4:
//                    cursorLocation = text.count + 2
//                case 5...7:
//                    cursorLocation = text.count + 3
//                case 8...9:
//                    cursorLocation = text.count + 4
//                case 10...11:
//                    cursorLocation = text.count + 5
//                default:
//                    cursorLocation = 1
//                }
//            }
//        }
        
//        let selectedRange = NSMakeRange(text.count, innerTextField.text?.count ?? 0)
////        let from = innerTextField.position(from: innerTextField.beginningOfDocument, offset: selectedRange.location)
//        let from = innerTextField.position(
//            from: innerTextField.beginningOfDocument,
//            offset: selectedRange.location
//        )
//
//        let to = innerTextField.position(
//            from: from!,
//            offset: selectedRange.length
//        )
//        innerTextField.selectedTextRange = innerTextField.textRange(
//            from: from!,
//            to: to!
//        )
        
        context.coordinator.setup(innerTextField)
        
        return innerTextField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldContainer>) {
        uiView.text = self.text
        context.coordinator.updateParent(self)
    }
}
