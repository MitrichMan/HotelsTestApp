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
            Color.background
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(fieldName)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
                
                if fieldFormat == .phoneNumber {
                    
                    TextFieldContainer(
                        placeholder: "+7 (***) ***-**-**",
                        text: $viewModel.formarttedPhoneNumber
                    )
                    .onAppear(perform: {
                        viewModel.formarttedPhoneNumber = text
                    })

                    //                    let textChangedBinding = Binding<String>(
                    //                        get: {
                    //                            viewModel.format(
                    //                                phone: self.text,
                    //                                mask: "+* (***) ***-**-**"
                    //                            )
                    //                        },
                    //                        set: {
                    //                            self.text = $0
                    //                            print(text)
                    //                        }
                    //                    )
                    //
                    //                    TextFieldContainer(
                    //                        placeholder: "+7 (***) ***-**-**",
                    //                        text: textChangedBinding
                    //                    )
                    
                } else {
                    TextField("", text: $text)
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
        text: "7",
        fieldName: "Phone Number",
        fieldFormat: .phoneNumber
    )
}