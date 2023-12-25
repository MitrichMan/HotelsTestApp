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
    
    let objectWillChange = ObservableObjectPublisher()
    
    private init() {}
}

enum BookingDataName: String {
    case hotelName = "Отель"
    case departure = "Вылет из"
    case arrivalCountry = "Страна, город"
    case dates = "Даты"
    case numberOfNights = "arrivalCountry"
    case room = "Номер"
}
