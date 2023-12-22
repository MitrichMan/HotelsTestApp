//
//  RoomView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct RoomView: View {
    @StateObject private var viewModel = RoomViewModel()
    
    let rooms: Rooms
    let hotel: Hotel
    let mokRooms = Rooms(
        rooms: [Room(
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
        )]
    )
    
    var body: some View {
        Text("Hello, World!")
            .navigationTitle(hotel.hotelName)
            .task {
                await viewModel.fetchHotel()
            }
    }
}

#Preview {
    RoomView(rooms: Rooms(
        rooms: [Room(
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
             hotel: Hotel(
                id: 0,
                hotelName: "",
                hotelAdress: "",
                horating: 0,
                ratingName: "",
                departure: "",
                arrivalCountry: "",
                tourDateStart: "",
                tourDateStop: "",
                numberOfNights: 0,
                room: "",
                nutrition: "",
                tourPrice: 0,
                fuelCharge: 0,
                serviceCharge: 0
             )
    )
}
