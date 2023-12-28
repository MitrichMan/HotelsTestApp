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
    let fieldFormat: FieldFormat
    
    @State private var phoneNumber: String = "+7 (***) ***-**-**"

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
                    
//                    let textChangedBinding = Binding<String>(
//                        get: {
//                            FilterPhoneNumber.format(
//                                phone: self.phoneNumber,
//                                mask: "+* (***) ***-**-**"
//                            )
//                        },
//
//                        set: {
//                            self.phoneNumber = $0
//                        }
//                    )
//                    TextFieldContainer(placeholder: "+7 (***) ***-**-**", text: $phoneNumber)
                    
                    TextField("+7 (***) ***-**-**", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .onAppear(perform: {
                            phoneNumber = text
                        })
//                    
                        .onChange(of: phoneNumber) {
                            chooseFormatting(for: fieldFormat)
                            text = phoneNumber
                        }
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
    
    func chooseFormatting(for field: FieldFormat) {
        if field == .phoneNumber {
            if !phoneNumber.isEmpty {
                phoneNumber = phoneNumber.formatPhoneNumber()
                text = phoneNumber
            }
        }
    }
}

#Preview {
    DataTextFieldView(
        text: .constant("+7 (***) ***-**-**"),
        fieldName: "Phone Number",
        fieldFormat: .phoneNumber
    )
}


struct TextFieldContainer: UIViewRepresentable {
        
    private var placeholder: String
    private var text: Binding<String>
    
    init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }
    
    func makeUIView(context: UIViewRepresentableContext<TextFieldContainer>) -> UITextField {
        let innerTextField = UITextField(frame: .zero)
        innerTextField.placeholder = placeholder
        innerTextField.text = text.wrappedValue
        innerTextField.keyboardType = .phonePad
        
        return innerTextField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldContainer>) {
        uiView.text = self.text.wrappedValue
    }
}

class FilterPhoneNumber: ObservableObject {
        
    static func format(phone: String, mask: String) -> String {
        let filteredPhoneNumber = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
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
