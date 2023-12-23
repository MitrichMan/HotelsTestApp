//
//  NetworkManager.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchHotel() async throws -> Hotel {
        guard let url = URL(string: API.hotelApi.rawValue) else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let hotel = try? decoder.decode(Hotel.self, from: data) else {
            throw NetworkError.decodingError
        } 
        return hotel
    }
    
    func fetchBookingData() async throws -> BookingData {
        guard let url = URL(string: API.hotelApi.rawValue) else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let bookingData = try? decoder.decode(BookingData.self, from: data) else {
            throw NetworkError.decodingError
        }
        return bookingData
    }
    
    func fetchRooms() async throws -> Rooms {
        guard let url = URL(string: API.roomsApi.rawValue) else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let rooms = try? decoder.decode(Rooms.self, from: data) else {
            throw NetworkError.decodingError
        }
        return rooms
    }
    
    func fetchImageData(from url: String) async throws -> Data {
        guard let imageURL = URL(string: url) else { throw NetworkError.invalidURL }
        guard let imageData = try? Data(contentsOf: imageURL) else { throw NetworkError.noData }
        return imageData
    }
}

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
}

enum API: String {
    case hotelApi = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
    case roomsApi = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
    case bookingDetailsApi = "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
}
