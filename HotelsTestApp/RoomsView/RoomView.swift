//
//  RoomView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct RoomView: View {
    let room: Room
    
    var body: some View {
        ZStack {
            Color.white
            VStack(alignment: .leading, spacing: 8) {
                CarouselView(
                    imageUrls:
                        room.imageUrls
                )
                Text("\(room.name)")
                    .font(.system(size: 22, weight: .medium))
                    .frame(alignment: .leading)
                
                TileStackView(
                    content: room.peculiarities,
                    foregroundColor: Color(.peculiarities),
                    backgroundColor: Color(.peculiaritiesBackground)
                )
                
                .frame(
                    height:
                        room.peculiarities.count <= 2 ? 32 : 68
                )
                
                TileView(
                    content:
                        Text("Подробнее о номере ") + Text(Image(systemName: "chevron.forward")),
                    foregroundColor:
                        Color("AboutTheRoomForeground"),
                    backlgroundColor:
                        Color("AboutTheRoomBackground")
                )
                .padding(.bottom, 8)
                
                PriceView(
                    price: "\(room.price) ₽",
                    pricePer: room.pricePer
                )
                .padding(.bottom, 8)
            }
            .padding(16)
        }
        .cornerRadius(12)
        .padding(.top, 8)
    }
}

#Preview {
    RoomView(
        room: Room(
        id: 1,
        name: "",
        price: 1,
        pricePer: "",
        peculiarities: [],
        imageUrls: []
    )
    )
}
