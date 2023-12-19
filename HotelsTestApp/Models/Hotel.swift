//
//  Hotel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation

struct Hotel: Decodable {
    let id: Int
    let hotelName: String
    let hotelAdress: String
    let horating: Int
    let ratingName: String
    let departure: String
    let arrivalCountry: String
    let tourDateStart: String //Date?
    let tourDateStop: String //Date?
    let numberOfNights: Int
    let room: String
    let nutrition: String
    let tourPrice: Int
    let fuelPrice: Int
    let serviceCharge: Int
}
