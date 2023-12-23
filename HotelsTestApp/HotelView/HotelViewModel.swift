//
//  HotelViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation
import Combine

class HotelViewModel: ObservableObject {
    
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
    
    var totalPrice = 0
    
    var images = DataManager.shared.images
            
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
    
    @MainActor func fetchHotel() async {
        do {
            hotel = try await NetworkManager.shared.fetchHotel()
        } catch {
            print(error)
        }
    }
}
