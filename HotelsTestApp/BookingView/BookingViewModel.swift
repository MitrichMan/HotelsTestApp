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
    
    let bookingDataViewData: [DataViewData] = []
    
    var customer = DataManager.shared.customer
    
    let bookingDataNames = DataManager.shared.bookingDataFieldNames
    let finalPriceNames = DataManager.shared.finalPriceFieldNames
    
    
    
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
    
    func prepareBookingDataViewData(names: [BookingDataFieldName]) -> [DataViewData] {
        var dataToDisplay: [DataViewData] = []
        
        for name in names {
            switch name {
            case .arrivalCountry:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: bookingData.arrivalCountry
                ))
            case .dates:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: "\(bookingData.tourDateStart) - \(bookingData.tourDateStop)"
                ))
            case .numberOfNights:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: String(bookingData.numberOfNights)
                ))
            case .hotelName:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: bookingData.hotelName
                ))
            case .room:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: bookingData.room
                ))
            case .nutrition:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: bookingData.nutrition
                ))
            case .departure:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: bookingData.departure
                ))
                
            case .tourPrice:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: "\(bookingData.tourPrice) ₽"
                ))
            case .fuelCharge:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: "\(bookingData.fuelCharge) ₽"
                ))
            case .serviceCharge:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: "\(bookingData.serviceCharge) ₽"
                ))
            case .totalPrice:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: "\(bookingData.tourPrice + bookingData.fuelCharge + bookingData.serviceCharge) ₽"
                ))
            }
        }
        return dataToDisplay
    }
}
