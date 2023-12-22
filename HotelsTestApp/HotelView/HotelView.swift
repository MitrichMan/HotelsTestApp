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
                                    images: viewModel.images,
                                    totalPrice: viewModel.totalPrice
                                )
                                .padding(.horizontal, 16)
                                .padding(.bottom)
                            }
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 30,
                                    bottomTrailingRadius: 30,
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
                            .cornerRadius(30)
                            
                        }
                    }
                    
                    GoToRoomSelectionButtonView(
                        rooms: Rooms(rooms: [Room(
                        id: 1,
                        name: "Стандартный номер с видом на бассейн",
                        price: 186600,
                        pricePer: "За 7 ночей с перелетом",
                        peculiarities: [
                            "Включен только завтрак",
                            "Кондиционер"
                        ],
                        imageUrls: [
                            "https://www.atorus.ru/sites/default/files/upload/image/News/56871/%D1%80%D0%B8%D0%BA%D1%81%D0%BE%D1%81%20%D1%81%D0%B8%D0%B3%D0%B5%D0%B9%D1%82.jpg",
                            "https://q.bstatic.com/xdata/images/hotel/max1024x768/267647265.jpg?k=c8233ff42c39f9bac99e703900a866dfbad8bcdd6740ba4e594659564e67f191&o=",
                            "https://worlds-trip.ru/wp-content/uploads/2022/10/white-hills-resort-5.jpeg"
                        ]
                    )]),
                        hotel: viewModel.hotel
                    )
                        .padding(.horizontal, 16)
                }
                
            }
            .navigationBarTitle("Отель")
            .navigationBarTitleDisplayMode(.inline)
            
            
            .task {
                await viewModel.fetchHotel()
            }
        }
    }
}

#Preview {
    HotelView()
}

struct GoToRoomSelectionButtonView: View {
    let rooms: Rooms
    let hotel: Hotel
    var body: some View {
        NavigationLink {
            RoomView(rooms: rooms, hotel: hotel)
            
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
