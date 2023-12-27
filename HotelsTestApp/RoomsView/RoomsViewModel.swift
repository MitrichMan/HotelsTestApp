//
//  RoomViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation
import Combine

class RoomsViewModel: ObservableObject {
    var rooms = Rooms(rooms: [Room(
        id: 1,
        name: "",
        price: 1,
        pricePer: "",
        peculiarities: [],
        imageUrls: []
    )]) {
        didSet {
            objectWillChange.send()
        }
    }
        
    let objectWillChange = ObservableObjectPublisher()
    
    @MainActor func fetchRooms() async {
        do {
            rooms = try await NetworkManager.shared.fetchRooms()
        } catch {
            print(error)
        }
    }
}
