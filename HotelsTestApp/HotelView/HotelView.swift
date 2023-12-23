//
//  HotelView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct HotelView: View {
    @StateObject private var viewModel = HotelViewModel()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                
                VStack {
                    ScrollView(.vertical) {
                        VStack(spacing: 8) {
                            
                            ZStack {
                                Color(.white)
                                
                                BasicDataView(
                                    hotel: viewModel.hotel,
                                    imageUrls: viewModel.hotel.imageUrls,
                                    totalPrice: viewModel.totalPrice
                                )
                                .padding(.horizontal, 16)
                                .padding(.bottom)
                            }
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 12,
                                    bottomTrailingRadius: 12,
                                    topTrailingRadius: 0
                                )
                            )
                            
                            ZStack {
                                Color(.white)
                                DetailedDataView(
                                    hotel: viewModel.hotel,
                                    buttons: DataManager.shared.buttons
                                )
                                .padding()
                            }
                            .cornerRadius(12)
                            
                        }
                    }
                    
                    GoToRoomSelectionButtonView(hotel: viewModel.hotel)
                        .padding(.horizontal, 16)
                }
                
            }
            .navigationBarTitle("Отель")
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
        .task {
            await viewModel.fetchHotel()
        }
    }
}

#Preview {
    HotelView()
}

struct GoToRoomSelectionButtonView: View {
//    let rooms: Rooms
    let hotel: Hotel
    var body: some View {
        NavigationLink {
            RoomView(hotel: hotel)
            
        } label: {
            HStack {
                Spacer()
                
                Text("К выбору номера")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .buttonStyle(.borderedProminent)
        .font(.system(size: 16, weight: .medium))
        .foregroundColor(.white)
    }
}
