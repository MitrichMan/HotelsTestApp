//
//  DataManager.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 21.12.2023.
//

import Foundation
import Combine

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    @Published var hotel = Hotel(
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
    ) {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var bookingData = BookingData(
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
    
    var buttons = [
        HotelButton(
            title: "Удобства",
            subTitle: "Самое необходимое",
            image: "smileButton"
        ),
        HotelButton(
            title: "Что включено",
            subTitle: "Самое необходимое",
            image: "checkMarkButton"
        ),
        HotelButton(
            title: "Что не включено",
            subTitle: "Самое необходимое",
            image: "crossButton"
        )
    ]
    
    let objectWillChange = ObservableObjectPublisher()
    
    private init() {}
    
    @MainActor func fetchHotel() async {
        do {
            hotel = try await NetworkManager.shared.fetchHotel()
        } catch {
            print(error)
            
        }
    }
}
