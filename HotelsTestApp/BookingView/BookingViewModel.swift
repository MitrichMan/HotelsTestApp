//
//  BookingViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation
import Combine

class BookingViewModel: ObservableObject {
    
    var bookingData: BookingData = BookingData(
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
            objectWillChange.send()
        }
    }
    
    let objectWillChange = ObservableObjectPublisher()
    
    @MainActor func fetchBookingData() async {
        do {
            bookingData = try await NetworkManager.shared.fetchBookingData()
        } catch {
            print(error.localizedDescription)
        }
    }
}
