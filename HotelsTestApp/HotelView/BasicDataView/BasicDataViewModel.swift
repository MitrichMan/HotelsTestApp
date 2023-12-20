//
//  BasicDataViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation

class BasicDataViewModel: ObservableObject {
    
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
        fuelPrice: 0,
        serviceCharge: 0
    )
    @Published var images = ["Image1", "Image2", "Image3", "Image4", "Image5"]
    
    func fetchHotel() async {
        do {
            hotel = try await NetworkManager.shared.fetchHotel()
        } catch {
            print(error)
        }
    }
    
//    func fetchCourses() async {
//        do {
//            let courses = try await NetworkManager.shared.fetchCourses()
//            rows = courses.map { CourseDetailsViewModel(course: $0) }
//        } catch {
//            print(error)
//        }
//    }
    
}
