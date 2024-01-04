//
//  DataTextFieldView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct DataTextFieldView: View {
    @State var text: String
    let fieldName: String
    let fieldFormat: FieldFormat
    
//    @State private var phoneNumber: String = "+7"// (***) ***-**-**"

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
                    
                    let textChangedBinding = Binding<String>(
                        get: {
                            FilterPhoneNumber.format(
                                phone: self.text,
                                mask: "+* (***) ***-**-**"
                            )
                        },
                        set: {
                            self.text = $0
                        }
                    )
                    
                    TextFieldContainer(
                        placeholder: "+7 (***) ***-**-**",
                        text: textChangedBinding
                    )
                    
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


struct TextFieldContainer: UIViewRepresentable {
        
    private var placeholder: String
    var text: Binding<String>
    
    init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }
    
    func makeCoordinator() -> TextFieldCoordinator {
        TextFieldCoordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TextFieldContainer>) -> UITextField {
        let innerTextField = UITextField(frame: .zero)
        innerTextField.placeholder = placeholder
        innerTextField.text = text.wrappedValue
        innerTextField.delegate = context.coordinator
        innerTextField.keyboardType = .phonePad
        
        context.coordinator.setup(innerTextField)
        
        return innerTextField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldContainer>) {
        uiView.text = self.text.wrappedValue
    }
}

class FilterPhoneNumber: ObservableObject {
        
    static func format(phone: String, mask: String) -> String {
        let filteredPhoneNumber = phone.replacingOccurrences(
            of: "[^0-9]", with: "",
            options: .regularExpression
        )
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

class TextFieldCoordinator: NSObject, UITextFieldDelegate {
       var parent: TextFieldContainer

       init(_ textFieldContainer: TextFieldContainer) {
           self.parent = textFieldContainer
       }

       func setup(_ textField: UITextField) {
           textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
       }

       @objc func textFieldDidChange(_ textField: UITextField) {
           self.parent.text.wrappedValue = textField.text ?? ""

           let newPosition = textField.endOfDocument
           textField.selectedTextRange = textField.textRange(
            from: newPosition,
            to: newPosition
           )
       }
   }
