//
//  HotelViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation
import SwiftUI

class HotelViewModel: ObservableObject {
    
    @Published var hotel = Hotel(
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
    ) {
        didSet {
            calculateTotalPrice()
        }
    }
    
    var totalPrice = 0
    
    var images = DataManager.shared.images
        
//    @Published var buttons = DataManager.shared.buttons
    
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
    
    @MainActor func fetchHotel() async {
        do {
            hotel = try await NetworkManager.shared.fetchHotel()
        } catch {
            print(error)
        }
    }
    
    private func calculateTotalPrice() {
        totalPrice = hotel.tourPrice + hotel.fuelCharge + hotel.serviceCharge
    }
}
