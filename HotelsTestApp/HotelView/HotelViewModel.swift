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
        minimalPrice: 0,
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
    @Published var tabBarHeight: CGFloat = 0

    
    let buttons = DataManager.shared.buttons
        
    let objectWillChange = ObservableObjectPublisher()
    
    @MainActor func fetchHotel() async {
        do {
            hotel = try await NetworkManager.shared.fetchHotel()
        } catch {
            print(error)
        }
    }
}
