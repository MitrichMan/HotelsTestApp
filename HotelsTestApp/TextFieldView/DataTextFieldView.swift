//
//  DataTextFieldView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct DataTextFieldView: View {
    
    @StateObject private var viewModel = DataTextFieldViewModel()
    @State var text: String = "" 
        
    let fieldName: String
    let fieldFormat: FieldFormat
        
    var body: some View {
        ZStack {
            Color(viewModel.backgroundColor)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(fieldName)
                        .foregroundStyle(.gray)
                        .onTapGesture {
                            viewModel.isFirstResponder = true
                        }
                    
                    Spacer()
                }
                
                if viewModel.wasTapped {
                    TextFieldContainer(
                        textIsValid: $viewModel.textIsValid,
                        text: $viewModel.text,
                        isFirstResponder: $viewModel.isFirstResponder,
                        fieldFormat: fieldFormat,
                        placeholder: viewModel.placeholder
                    )
                }
            }
            
            .onAppear(perform: {
                viewModel.text = text
                viewModel.fieldFormat = fieldFormat
            })
            
            .onChange(of: text) {
                if fieldFormat == .phoneNumber {
                    text = viewModel.formattedPhoneNumber
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

#Preview {
    DataTextFieldView(
        text: "",
        fieldName: CustomerDataFieldName.email.rawValue,
        fieldFormat: .email
    )
}
