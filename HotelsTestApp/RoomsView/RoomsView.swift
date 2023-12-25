//
//  RoomsView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct RoomsView: View {
    @StateObject private var viewModel = RoomsViewModel()
        
    var body: some View {
        NavigationView {
                ZStack {
                    Color("Background")
                    ScrollView {
                    
                    VStack(spacing: 0) {
                        ForEach(0...viewModel.rooms.rooms.count - 1, id: \.self) { index in
                            RoomView(room: viewModel.rooms.rooms[index])
                        }
                    }
                }
            }
        }
        
        .task {
            await viewModel.fetchRooms()
        }
    }
}

#Preview {
    RoomsView()
}

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
                
                PeculiaritiesTilesView(
                    peculiarities: room.peculiarities,
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
                
                GoToDestinationButtonView(
                    destination: BookingView(),
                    text: "Выбрать номер"
                )
            }
            .padding(16)
        }
        .cornerRadius(12)
        .padding(.top, 8)
    }
}
