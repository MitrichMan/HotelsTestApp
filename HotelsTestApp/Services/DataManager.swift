//
//  DataManager.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 21.12.2023.
//

import Foundation

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
    
    var customer = Customer(
        phone: "",
        email: ""
    )
    
    var tourists: [Tourist] = [Tourist(
        name: "",
        lastName: "",
        dateOfBirth: "",
        citizenship: "",
        passportNumber: "",
        passportExpirationDate: ""
    )] 
    
    let bookingDataFieldNames: [BookingDataFieldName] = [
        .departure,
        .arrivalCountry,
        .dates,
        .numberOfNights,
        .hotelName,
        .room,
        .nutrition
    ]
    
    let customerDataFieldNames: [CustomerDataFieldName] = [
        .phone,
        .email
    ]
    
    
    let touristDataFieldNames: [TouristDataFieldName] = [
        .name,
        .lastName,
        .dateOfBirth,
        .citizenship,
        .passportNumber,
        .passportExpirationDate
    ]
    
    let finalPriceFieldNames: [BookingDataFieldName] = [
        .tourPrice,
        .fuelCharge,
        .serviceCharge,
        .totalPrice
    ]
        
    private init() {}
    
//    func prepareBookingData(name: BookingDataFieldName, data: BookingData) -> String {
//        switch name {
//        case .arrivalCountry:
//            data.arrivalCountry
//        case .dates:
//            "\(data.tourDateStop) - \(data.tourDateStop)"
//        case .numberOfNights:
//            "\(data.numberOfNights)"
//        case .hotelName:
//            data.hotelName
//        case .room:
//            data.room
//        case .nutrition:
//            data.nutrition
//        case .departure:
//            data.departure
//            
//        case .tourPrice:
//            String(data.tourPrice)
//        case .fuelCharge:
//            String(data.fuelCharge)
//        case .serviceCharge:
//            String(data.serviceCharge)
//        case .totalPrice:
//            String(data.tourPrice + data.fuelCharge + data.serviceCharge)
//        }
//    }
    
    func prepareBookingDataViewData(names: [BookingDataFieldName], from bookingData: BookingData) -> [DataViewData] {
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
    
    func makeCustomer(phone: String, email: String) {
        customer.phone = phone
        customer.email = email
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
    
    func prepareMockPersonalData() -> PersonalData {
        PersonalData(
            customer: customer,
            tourists: tourists
        )
    }
    
    func getMask(for fieldFormat: FieldFormat) -> String {
        switch fieldFormat {
            
        case .string:
            return ""
        case .number:
            return ""
        case .phoneNumber:
            return "+* (***) ***-**-**"
        case .email:
            return "****@***.com"
        case .date:
            return "**.**.****"
        }
    }
    
    func getRegex(for fieldFormat: FieldFormat) -> String {
        switch fieldFormat {
            
        case .string:
            return ""
        case .number:
            return ""
        case .phoneNumber:
            return ""
        case .email:
            return "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        case .date:
            return ""
        }
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

enum CustomerDataFieldName: String {
    case phone = "Номер телефона"
    case email = "Электронная почта"
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
    case email
    case date
}

enum TextFieldTextMask: String {
    case phone = "+* (***) ***-**-**"
    case date = "**.**.****"
}
