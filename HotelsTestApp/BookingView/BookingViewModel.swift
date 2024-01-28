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
                    subtitle: bookingData.arrivalCountry, 
                    presentationMode: .narrow
                ))
            case .dates:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: "\(bookingData.tourDateStop) - \(bookingData.tourDateStop)",
                    presentationMode: .narrow
                ))
            case .numberOfNights:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: String(bookingData.numberOfNights),
                    presentationMode: .narrow
                ))
            case .hotelName:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: bookingData.hotelName, 
                    presentationMode: .narrow
                ))
            case .room:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: bookingData.room, 
                    presentationMode: .narrow
                ))
            case .nutrition:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: bookingData.nutrition, 
                    presentationMode: .narrow
                ))
            case .departure:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: bookingData.departure, 
                    presentationMode: .narrow
                ))
                
            case .tourPrice:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: "\(bookingData.tourPrice) ₽",
                    presentationMode: .wide
                ))
            case .fuelCharge:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: "\(bookingData.fuelCharge) ₽",
                    presentationMode: .wide
                ))
            case .serviceCharge:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: "\(bookingData.serviceCharge) ₽",
                    presentationMode: .wide
                ))
            case .totalPrice:
                dataToDisplay.append(DataViewData(
                    title: name.rawValue,
                    subtitle: "\(bookingData.tourPrice + bookingData.fuelCharge + bookingData.serviceCharge) ₽",
                    presentationMode: .wide
                ))
            }
        }
        
        return dataToDisplay
    }
}
