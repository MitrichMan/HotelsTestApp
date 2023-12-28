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
        
        let mask = "+* (***) ***-**-**"
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        let endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "*" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result + mask.dropFirst(result.count)
    }
}
