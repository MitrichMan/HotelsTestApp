//
//  HotelViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation

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
    
    @Published var totalPrice = 0
    
    @Published var images = ["Image1", "Image2", "Image3", "Image4", "Image5"]
    
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
