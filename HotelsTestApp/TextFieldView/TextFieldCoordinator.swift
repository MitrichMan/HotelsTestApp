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
        if parent.fieldFormat == .phoneNumber {
            textField.addTarget(self, action: #selector(phoneNumberFieldDidChange), for: .editingChanged)
        } else {
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    func updateParent(_ parent : TextFieldContainer) {
        self.parent = parent
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.parent.text = text
    }
    
    @objc func phoneNumberFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        self.parent.text = text
        
        let phoneNumber = formatTextToPhoneNumber(phone: text, mask: "+* (***) ***-**-**")
        
        if textField.text != phoneNumber {
            textField.text = phoneNumber
        }
        
        setCursor(in: textField)
//        print("parent.text \(parent.text)")
    }
    
    private func formatTextToPhoneNumber(phone: String, mask: String) -> String {
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
    
    private func setCursor(in textField: UITextField) {
        guard let text = textField.text else { return }
        
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
    }
}
