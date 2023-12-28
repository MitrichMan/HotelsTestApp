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
    
    let buttons = [
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
    
    let customerData = CustomerData(
        phone: "",
        email: "examplemail.000@mail.ru"
        //        +7 (951) 555-99-00
    )
    
    var tourists: [Tourist] = [Tourist(
        name: "",
        lastName: "",
        dateOfBirth: "",
        citizenship: "",
        passportNumber: "",
        passportExpirationDate: ""
    )] 
    
    let bookingDataNames: [BookingDataFieldName] = [
        .departure,
        .arrivalCountry,
        .dates,
        .numberOfNights,
        .hotelName,
        .room,
        .nutrition
    ]
    
    let touristDataFieldNames: [TouristDataFieldName] = [
        .name,
        .lastName,
        .dateOfBirth,
        .citizenship,
        .passportNumber,
        .passportExpirationDate
    ]
    
    let finalPriceNames: [BookingDataFieldName] = [
        .tourPrice,
        .fuelCharge,
        .serviceCharge,
        .totalPrice
    ]
    
    let objectWillChange = ObservableObjectPublisher()
    
    private init() {}
    
    func prepareBookingData(name: BookingDataFieldName, data: BookingData) -> String {
        switch name {
        case .arrivalCountry:
            data.arrivalCountry
        case .dates:
            "\(data.tourDateStop) - \(data.tourDateStop)"
        case .numberOfNights:
            "\(data.numberOfNights)"
        case .hotelName:
            data.hotelName
        case .room:
            data.room
        case .nutrition:
            data.nutrition
        case .departure:
            data.departure
            
        case .tourPrice:
            String(data.tourPrice)
        case .fuelCharge:
            String(data.fuelCharge)
        case .serviceCharge:
            String(data.serviceCharge)
        case .totalPrice:
            String(data.tourPrice + data.fuelCharge + data.serviceCharge)
        }
    }
    
    func prepareTouristData(name: TouristDataFieldName, data: Tourist) -> String {
        switch name {
        case .name:
            data.name
        case .lastName:
            data.lastName
        case .dateOfBirth:
            data.dateOfBirth
        case .citizenship:
            data.citizenship
        case .passportNumber:
            data.passportNumber
        case .passportExpirationDate:
            data.passportExpirationDate
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

enum BookingDataFieldName: String {
    case departure = "Вылет из"
    case arrivalCountry = "Страна, город"
    case dates = "Даты"
    case numberOfNights = "Кол-во ночей"
    case hotelName = "Отель"
    case room = "Номер"
    case nutrition = "Питание"
    
    case tourPrice = "Тур"
    case fuelCharge = "Топливный сбор"
    case serviceCharge = "Сервисный сбор"
    case totalPrice = "К оплате"
}

enum TouristDataFieldName: String {
    case name = "Имя"
    case lastName = "Фамилия"
    case dateOfBirth = "Дата рождения"
    case citizenship = "Гражданство"
    case passportNumber = "Номер загранпаспорта"
    case passportExpirationDate =  "Срок действия загранпаспорта"
}

enum PresentationMode {
    case narrow
    case wide
}

enum FieldFormat {
    case string
    case number
    case phoneNumber
}
