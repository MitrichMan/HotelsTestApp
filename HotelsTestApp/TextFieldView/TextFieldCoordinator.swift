//
//  TextFieldCoordinator.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 11.01.2024.
//

import UIKit

class TextFieldCoordinator: NSObject, UITextFieldDelegate {
    var parent: TextFieldContainer
    
    init(_ textFieldContainer: TextFieldContainer) {
        self.parent = textFieldContainer
    }
    
    func setup(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func updateParent(_ parent : TextFieldContainer) {
        self.parent = parent
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.parent.text.wrappedValue = textField.text ?? ""
        
        guard let text = textField.text else { return }
        
        let realCount = text.filter{ "0123456789".contains($0) }.count
        
        let newPosition = textField.beginningOfDocument
                    textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        
        textField.selectedTextRange = textField.textRange(
            from: textField.position(
                from: textField.beginningOfDocument,
                offset: realCount
            )!,
            to: textField.position(
                from: textField.beginningOfDocument,
                offset: realCount
            )!
        )
//        print(textField.selectedTextRange)
        
        
//        if let newPosition = textField.position(
//            from: textField.beginningOfDocument,
//            offset: -5
//        ) {
//            textField.selectedTextRange = textField.textRange(
//                from: newPosition,
//                to: newPosition
//            )
//        }
    }
}


//    // для полей с маской, необходимо вручную установить курсор после изменения поля
//    private func _setCursor(
//        text: String,
//        updatedText: String,
//        range: NSRange,
//        replacementString: String
//    ) {
//        if _textField.selectedTextRange != nil {
//            // В некоторых местах по маске автоматически добавляются дополнительные символы
//            // мы должны учесть эту дополнительную подстановку при подсчете места курсора
//            var addingCount = 1
//
//
//
//            let offset = range.location + addingCount
//            if let newPosition = _textField.position(
//                from: _textField.beginningOfDocument,
//                offset: offset
//            ) {
//                _textField.selectedTextRange = _textField.textRange(
//                    from: newPosition,
//                    to: newPosition
//                )
//            }
//        }
