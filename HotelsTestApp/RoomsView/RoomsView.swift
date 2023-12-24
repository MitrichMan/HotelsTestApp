//
//  RoomsView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct RoomsView: View {
    @StateObject private var viewModel = RoomsViewModel()
    
    let hotel: Hotel
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Color("Background")
                    
                    VStack {
                        ForEach(0...viewModel.rooms.rooms.count - 1, id: \.self) { index in
                            ZStack {
                                Color.white
                                VStack {
                                    CarouselView(
                                        imageUrls: viewModel.rooms.rooms[index].imageUrls
                                    )
                                    Text("\(viewModel.rooms.rooms[index].name)")
                                    
                                    PeculiaritiesTilesView(
                                        peculiarities: viewModel.rooms.rooms[index].peculiarities
                                    )
                                    
                                    TileView(
                                        content: "Подробнее о номере 〉",
                                        foregroundColor: Color(.aboutTheRoomsForeground),
                                        backlgroundColor: Color(.aboutTheRoomsBackground)
                                    )
                                    
                                }
                                .padding(16)
                            }
                            .clipShape(.rect(
                                topLeadingRadius: index == 0 ? 0 : 12,
                                bottomLeadingRadius: 12,
                                bottomTrailingRadius: 12,
                                topTrailingRadius: index == 0 ? 0 : 12
                            ))
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(hotel.name)
        
        .task {
            await viewModel.fetchRooms()
        }
    }
}

#Preview {
    //        id: 0,
    //        hotelName: "",
    //        hotelAdress: "",
    //        horating: 0,
    //        ratingName: "",
    //        departure: "",
    //        arrivalCountry: "",
    //        tourDateStart: "",
    //        tourDateStop: "",
    //        numberOfNights: 0,
    //        room: "",
    //        nutrition: "",
    //        tourPrice: 0,
    //        fuelCharge: 0,
    //        serviceCharge: 0
    RoomsView(
        hotel: Hotel(
            id: 1,
            name: "",
            adress: "",
            minimalPrice: 1,
            priceForIt: "",
            rating: 1,
            ratingName: "",
            imageUrls: [],
            aboutTheHotel: AboutTheHotel(
                description: "",
                peculiarities: []
            )
        )
    )
}
