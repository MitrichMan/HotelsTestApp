//
//  Extensions.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 28.12.2023.
//

import Foundation

extension String {
    func formatPhoneNumber() -> String {
        let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "+Y (XXX) XXX-XX-XX"
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        let endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "Y" {
                result.append("7")
                startIndex = cleanNumber.index(after: startIndex)
            } else if char == "X" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}
