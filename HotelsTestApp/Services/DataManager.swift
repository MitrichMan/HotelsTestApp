//
//  DataManager.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 21.12.2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
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
    ) 
    
    let images = ["Image1", "Image2", "Image3", "Image4", "Image5"]
    
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
    
    private init() {}
    
    @MainActor func fetchHotel() async {
        do {
            hotel = try await NetworkManager.shared.fetchHotel()
        } catch {
            print(error)
            
        }
    }
}
