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
                
                DataTextFieldView(
                    text: $phone, 
                    fieldName: "Номер телефона"
                )
                
                DataTextFieldView(
                    text: $email, 
                    fieldName: "Почта"
                )
                
                Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                    .padding(.vertical)
            }
        }
        .cornerRadius(12)
    }
}
