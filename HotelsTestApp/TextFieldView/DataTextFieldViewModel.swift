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
    
    @Published var placeholder = ""

    @Published var isRedacted = false
    
    var fieldFormat: FieldFormat = .string {
        didSet {
            switch fieldFormat {
            case .string:
                text = "String"
                placeholder = "String"
                return
            case .number:
                text = "12456"
                placeholder = "12345"
                return
            case .phoneNumber:
                formattedPhoneNumber = "7"
                text = formattedPhoneNumber
                placeholder = CustomerDataFieldName.phone.rawValue
            case .email:
                placeholder = CustomerDataFieldName.email.rawValue
                return
            }
        }
    }
    
    var formattedPhoneNumber = "" {
        didSet {
            let formattedText = format(phone: formattedPhoneNumber, mask: "+* (***) ***-**-**")
            
            if formattedPhoneNumber != formattedText {
                formattedPhoneNumber = formattedText
            }
            
            if text != formattedPhoneNumber {
                text = formattedPhoneNumber
            }
//            print("formattedPhoneNumber \(formattedPhoneNumber)")
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
}
