//
//  Hotel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation

struct Hotel: Decodable {
    
    let id: Int
    let name: String
    let adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let aboutTheHotel: AboutTheHotel
}

struct AboutTheHotel: Decodable {
    let description: String
    let peculiarities: [String]
}

struct BookingData: Decodable {
    let id: Int
    let hotelName: String
    let hotelAdress: String
    let horating: Int
    let ratingName: String
    let departure: String
    let arrivalCountry: String
    let tourDateStart: String
    let tourDateStop: String
    let numberOfNights: Int
    let room: String
    let nutrition: String
    let tourPrice: Int
    let fuelCharge: Int
    let serviceCharge: Int

}

struct Rooms: Decodable {
    let rooms: [Room]
}

struct Room: Decodable {
    let id: Int
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: [String]
    let imageUrls: [String]
}

struct Customer {
    var phone: String
    var email: String
}

struct Tourist {
    var name: String
    var lastName: String
    var dateOfBirth: String
    var citizenship: String
    var passportNumber: String
    var passportExpirationDate: String
    var isPresented = true
}

struct HotelButton {    
    let title: String
    let subTitle: String
    let image: String
}

struct DataViewData: Hashable {
    let title: String
    let subtitle: String
    let presentationMode: PresentationMode
}

struct PersonalData {
    var customer: Customer
    var tourists: [Tourist]
}
