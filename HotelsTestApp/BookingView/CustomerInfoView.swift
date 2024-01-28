//
//  CustomerInfoView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct CustomerInfoView: View {
    @Binding var phone: String
    @Binding var email: String
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Информация о покупателе")
                    .font(.system(size: 22, weight: .medium))
                    .padding(.horizontal)
                    .padding(.top)
                
                ForEach(DataManager.shared.customerDataFieldNames, id: \.self) { name in
                    DataTextFieldView(
                        text: name == .phone ? phone : email,
                        fieldName: name.rawValue,
                        fieldFormat: chooseFieldFormat(for: name)
                    )
                }
                
                Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                    .padding(.vertical)
            }
        }
        .cornerRadius(12)
    }
    
    func chooseFieldFormat(for textFieldName: CustomerDataFieldName) -> FieldFormat {
        switch textFieldName {
        case .phone:
            return .phoneNumber
        case .email:
            return .email
        }
    }
}
