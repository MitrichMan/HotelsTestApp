//
//  BookingViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation
import Combine

final class BookingViewModel: ObservableObject {
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
            hotelData = DataManager.shared.prepareBookingDataViewData(
                names: DataManager.shared.bookingDataFieldNames,
                from: bookingData
            )
            
            priceData = DataManager.shared.prepareBookingDataViewData(
                names: DataManager.shared.finalPriceFieldNames,
                from: bookingData
            )
            
            objectWillChange.send()
        }
    }
    
    var tourists: [Tourist] = [Tourist(
        name: "",
        lastName: "",
        dateOfBirth: "",
        citizenship: "",
        passportNumber: "",
        passportExpirationDate: ""
    )] {
        didSet {
            objectWillChange.send()
        }
    }
    
    var hotelData: [DataViewData] = []
    var priceData: [DataViewData] = []
        
    var customer = DataManager.shared.customer
    
    let objectWillChange = ObservableObjectPublisher()
    
    @MainActor func fetchBookingData() async {
        do {
            bookingData = try await NetworkManager.shared.fetchBookingData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addTourist() {
        tourists.append(Tourist(
            name: "",
            lastName: "",
            dateOfBirth: "",
            citizenship: "",
            passportNumber: "",
            passportExpirationDate: ""
        ))
    }
}
