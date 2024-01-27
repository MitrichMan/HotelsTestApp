//
//  DataTextFieldViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 11.01.2024.
//

//import Foundation
import UIKit

class DataTextFieldViewModel: ObservableObject {
    
    @Published var text = "" {
        didSet {
            
        }
    }
    
     var placeholder = ""

    @Published var isFirstResponder = false {
        didSet {
            if !wasTapped {
                wasTapped.toggle()
            }
            print("VM isFirstResponder = \(isFirstResponder)")
        }
    }
    
    @Published var wasTapped = false
        
    var textIsValid = true {
        didSet {
            if textIsValid  {
                backgroundColor = UIColor(.background)
            } else {
                backgroundColor = UIColor(.red).withAlphaComponent(0.15)
            }
        }
    }
    
    @Published var backgroundColor = UIColor(.background)
    
    var fieldFormat: FieldFormat = .string {
        didSet {
            switch fieldFormat {
            case .string:
//                text = "String"
//                placeholder = "String"
                return
            case .number:
//                text = "12456"
//                placeholder = "12345"
                return
            case .phoneNumber:
                formattedPhoneNumber = "7"
                text = formattedPhoneNumber
                placeholder = CustomerDataFieldName.phone.rawValue
            case .email:
                formattedEmail = "&-#_%.^sdfx@rfgcvgv"
                text = formattedEmail
                placeholder = CustomerDataFieldName.email.rawValue
            }
        }
    }
    
    var formattedPhoneNumber = "" {
        didSet {
            let formattedText = format(phone: formattedPhoneNumber, mask: TextFieldTextMask.phone.rawValue)
            
            if formattedPhoneNumber != formattedText {
                formattedPhoneNumber = formattedText
            }
            
            if text != formattedPhoneNumber {
                text = formattedPhoneNumber
            }
        }
    }
    
    var formattedEmail = "" {
        didSet {
            let formattedText = formatEmail(email: formattedEmail, mask: "****@***.com")
            
            if formattedEmail != formattedText {
                formattedEmail = formattedText
            }
            
            if text != formattedEmail {
                text = formattedEmail
            }
        }
    }
    
//    func validate(text: String/*, regex: String*/) -> Bool {
//        if text.count > 100 {
//            return false
//        }
//        let emailRegex = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
//        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
//        return emailPredicate.evaluate(with: text)
//    }
    
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
    
    func formatEmail(email: String, mask: String) -> String {
        let filteredEmail = email.replacingOccurrences(
            of: "[^A-Z, a-z, 0-9, _ . -]", with: "",
            options: .regularExpression
        )
        
//        static let emailTyping = Regex(#"^[a-zA-Z0-9+.@_-]*$"#)
//
//            let emailRegex = try Regex(
//                "^(?=([a-z0-9+`_.-]*[a-z0-9+`_-]+@(([a-z0-9]+[a-z0-9_.-]*[a-z0-9]+)|[a-z0-9])\\.[a-z]{2,})$)(?!(.*\\.{2,}.*))(?!(.*@.*((\\.-)|(-\\.)).*))"
//        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        var result = ""
        var index = filteredEmail.startIndex
        
        for character in mask where index < filteredEmail.endIndex {
            if character == "*" {
                result.append(filteredEmail[index])
                index = filteredEmail.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        return result
    }
}
