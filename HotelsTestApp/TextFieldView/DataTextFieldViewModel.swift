//
//  DataTextFieldViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 11.01.2024.
//

//import Foundation
import UIKit

class DataTextFieldViewModel: ObservableObject {
    @Published var text = ""
    @Published var isFullyPresented = false
    @Published var backgroundColor = UIColor(.background)
    @Published var isFirstResponder = false {
        didSet {
            if !isFullyPresented {
                isFullyPresented.toggle()
            }
        }
    }
    
    var formattedText = "" {
        didSet {
            let formattedText = format(text: self.formattedText, as: fieldFormat)
            
            if self.formattedText != formattedText {
                self.formattedText = formattedText
            }
            
            text = self.formattedText
        }
    }
    
    var textIsValid = true {
        didSet {
            if textIsValid  {
                backgroundColor = UIColor(.background)
            } else {
                backgroundColor = UIColor(.red).withAlphaComponent(0.15)
            }
        }
    }
    
    var fieldFormat: FieldFormat = .string {
        didSet {
            switch fieldFormat {
            case .string:
                return
            case .number:
                return
            case .phoneNumber:
                formattedText = "7"
                text = formattedText
                placeholder = CustomerDataFieldName.phone.rawValue
            case .email:
                formattedText = "&-#_%.^sdfx@rfgcvgv"
                text = formattedText
                placeholder = CustomerDataFieldName.email.rawValue
            case .date:
                text = "00.00.0000"
                placeholder = TouristDataFieldName.dateOfBirth.rawValue
            }
        }
    }
    
    var placeholder = ""
    
    func format(text: String, as format: FieldFormat) -> String {
        let mask = DataManager.shared.getMask(for: format)
        
        var filterRegex = ""
        
        switch format {
        case .string:
            filterRegex = "[^A-Z, a-z, А-Я, а-я]"
        case .number:
            filterRegex = "[^0-9]"
        case .phoneNumber:
            filterRegex = "[^0-9]"
        case .email:
            filterRegex = "[^A-Z, a-z, 0-9, _ . -]"
        case .date:
            filterRegex = "[^0-9]"
        }
        
        var filteredText = text.replacingOccurrences(
            of: filterRegex, with: "",
            options: .regularExpression
        ) {
            didSet {
                if format == .phoneNumber {
                    if filteredText == "" {
                        filteredText = "7"
                    }
                }
            }
        }
        
        var result = ""
        var index = filteredText.startIndex
        
        for character in mask where index < filteredText.endIndex {
            if character == "*" {
                result.append(filteredText[index])
                index = filteredText.index(after: index)
            } else {
                result.append(character)
            }
        }
        if format == .phoneNumber {
            return result + mask.dropFirst(result.count)
        } else {
            return result
        }
    }
////        static let emailTyping = Regex(#"^[a-zA-Z0-9+.@_-]*$"#)
////
////            let emailRegex = try Regex(
////                "^(?=([a-z0-9+`_.-]*[a-z0-9+`_-]+@(([a-z0-9]+[a-z0-9_.-]*[a-z0-9]+)|[a-z0-9])\\.[a-z]{2,})$)(?!(.*\\.{2,}.*))(?!(.*@.*((\\.-)|(-\\.)).*))"
////        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
}
