//
//  DataTextFieldView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct DataTextFieldView: View {
    @Binding var text: String
    let fieldName: String
    @State var phoneNumber: String = ""
    
    var body: some View {
        ZStack {
            Color.background
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(fieldName)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
//                +7 (000)-000-00-00
                TextField("", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .onChange(of: phoneNumber) {
                        if !phoneNumber.isEmpty {
                            phoneNumber = phoneNumber.formatPhoneNumber()
                        }
                    }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
        }
        .frame(height: 52)
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.top, 16)
    }
}
