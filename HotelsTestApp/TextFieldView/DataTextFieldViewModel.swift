//
//  DataTextFieldViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 11.01.2024.
//

import Foundation

class DataTextFieldViewModel: ObservableObject {
    
//    var text = "" {
//        didSet {
//            formarttedPhoneNumber = text
//        }
//    }

    @Published var formarttedPhoneNumber = "" {
        didSet {
            let formattedText = format(phone: formarttedPhoneNumber, mask: "+* (***) ***-**-**")
            
            if formarttedPhoneNumber != formattedText {
                formarttedPhoneNumber = formattedText
            }
        }
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
    
    func setCursor(text: String) {
        
        
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
