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
        guard let unformattedText = textField.text else { return }
        
        self.parent.text = unformattedText
        
        let text = format(phone: unformattedText, mask: "+* (***) ***-**-**")
        
        if textField.text != text {
            textField.text = text
        }
      
        //Setting the cursor at the right place
        let realCount = text.filter{ "0123456789".contains($0) }.count
        
        var cursorLocation: Int {
            switch realCount {
            case 0...1:
                return realCount + 1
            case 2...4:
                return realCount + 3
            case 5...7:
                return realCount + 5
            case 8...9:
                return realCount + 6
            case 10...11:
                return realCount + 7
            default:
                return 1
            }
        }
        
        let selectedRange = NSMakeRange(text.count, text.count)
                
        let from = textField.position(
            from: textField.beginningOfDocument,
            offset: cursorLocation
        )
        
        let to = textField.position(
            from: textField.beginningOfDocument,
            offset: cursorLocation
        )
        
        textField.selectedTextRange = textField.textRange(
            from: from ?? textField.beginningOfDocument,
            to: to ?? textField.beginningOfDocument
        )
        
        print(text)
        print(realCount)
        print(cursorLocation)
        print(textField.selectedTextRange)
        print(selectedRange)
        print(selectedRange.location)
        
        //        let newPosition = textField.beginningOfDocument
        //        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        //
        //        textField.selectedTextRange = textField.textRange(
        //            from: textField.position(
        //                from: textField.beginningOfDocument,
        //                offset: realCount
        //            )!,
        //            to: textField.position(
        //                from: textField.beginningOfDocument,
        //                offset: realCount
        //            )!
        //        )
        //        print(textField.selectedTextRange)
    }
    
    func format(phone: String, mask: String) -> String {
        
        var filteredPhoneNumber = phone.replacingOccurrences(
            of: "[^0-9]", with: "",
            options: .regularExpression
        ) {
            didSet {
                if filteredPhoneNumber == "" {
                    filteredPhoneNumber = "7"
                }
            }
        }
        var result = ""
        var index = filteredPhoneNumber.startIndex
        
        for character in mask where index < filteredPhoneNumber.endIndex {
            if character == "*" {
                result.append(filteredPhoneNumber[index])
                index = filteredPhoneNumber.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result + mask.dropFirst(result.count)
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
