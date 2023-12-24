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
    
    let index: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                
                Text("\(viewModel.rooms.rooms.count)")
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
    RoomsView(hotel: Hotel(
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
    ), index: 0)
}
