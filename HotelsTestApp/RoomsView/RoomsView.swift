//
//  RoomsView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct RoomsView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = RoomsViewModel()
    
    var body: some View {
        ZStack {
            Color("Background")
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0...viewModel.rooms.rooms.count - 1, id: \.self) { index in
                        RoomView(
                            room: viewModel.rooms.rooms[index]
                        )
                        
                        GoToDestinationButtonView(
                            text: "Выбрать номер",
                            page: .booking
                        )
                    }
                }
            }
        }
        .navigationTitle("ERTYUILKJH")
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Button(action: {
            coordinator.pop()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        }))
        
        .task {
            await viewModel.fetchRooms()
        }
    }
}

#Preview {
    RoomsView()
}
