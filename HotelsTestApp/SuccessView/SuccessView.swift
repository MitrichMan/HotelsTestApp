//
//  SuccessView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct SuccessView: View {
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
            VStack {
                Spacer()
                
                ZStack {
                    Circle()
                        .frame(width: 94)
                        .foregroundColor(.background)
                    
                    Text("🎉")
                        .font(.system(size: 40))
                }
                
                Text("Ваш заказ принят в работу")
                    .font(.system(size: 22, weight: .medium))
                
                Text("Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
                    .foregroundStyle(.peculiarities)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Заказ оплачен")
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: Button(action: {
                coordinator.pop()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }))
        
        GoToDestinationButtonView(
            text: "Супер!",
            page: .hotel
        )
            .padding()
    }
}

#Preview {
    SuccessView()
}
