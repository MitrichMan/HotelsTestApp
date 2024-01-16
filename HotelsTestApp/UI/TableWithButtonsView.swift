//
//  TableWithButtonsView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 28.12.2023.
//

import SwiftUI

struct TableWithButtonsView: View {
    let buttons: [HotelButton]
    
    var body: some View {
        ZStack {
            Color(.peculiaritiesBackground)
            VStack {
                ForEach((0...buttons.count - 1), id: \.self) { index in
                    HStack {
                        Image(buttons[index].image)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .offset(y: -5)
                        VStack {
                            ListRowView(
                                title: buttons[index].title,
                                subTitle: buttons[index].subTitle
                            )
                            if index != buttons.count - 1 {
                                Divider()
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 16)
        }
        .cornerRadius(15)
    }
}


#Preview {
    TableWithButtonsView(buttons: DataManager.shared.buttons)
}
