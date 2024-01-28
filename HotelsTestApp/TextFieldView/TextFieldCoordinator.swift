//
//  TextFieldCoordinator.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 11.01.2024.
//

import UIKit

class TextFieldCoordinator: NSObject, UITextFieldDelegate {
    var parent: TextFieldContainer
    
    var textIsValid = true
    
    init(_ textFieldContainer: TextFieldContainer) {
        self.parent = textFieldContainer
    }
    
    func setup(_ textField: UITextField) {
        if parent.fieldFormat == .phoneNumber {
            textField.addTarget(self, action: #selector(phoneNumberFieldDidChange), for: .editingChanged)
        } else {
            textField.addTarget(self, action: #selector(textFieldDidEndChange), for: .editingDidEnd)
        }
        
    }
    
    func updateParent(_ parent : TextFieldContainer) {
        self.parent = parent
    }
    
    @objc func textFieldDidEndChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        textIsValid = validate(text: text)
        
        if self.parent.textIsValid != textIsValid {
            self.parent.textIsValid = textIsValid
        }
        if self.parent.text.count != 0 {
            if self.parent.isFirstResponder {
                self.parent.isFirstResponder = false
            }
        }
        
        self.parent.text = text
    }
    
    @objc func phoneNumberFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        let phoneNumber = formatTextToPhoneNumber(
            phone: text,
            mask: DataManager.shared.getMask(for: parent.fieldFormat)
        )
        
        if textField.text != phoneNumber {
            textField.text = phoneNumber
        }
        
        self.parent.text = phoneNumber
        
        setCursor(in: textField)
    }
    
    func validate(text: String) -> Bool {
        if text.count > 100 {
            return false
        }
        
        let emailRegex = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: text)
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
