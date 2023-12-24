//
//  RoomViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation
import Combine

class RoomsViewModel: ObservableObject {
    @Published var rooms = Rooms(rooms: []) {
        didSet {
            print(rooms.rooms.count)
            objectWillChange.send()
        }
    }
    
    
    @Published var roomImages: [Data] = []
    
    let objectWillChange = ObservableObjectPublisher()
    
    @MainActor func fetchRooms() async {
        do {
            rooms = try await NetworkManager.shared.fetchRooms()
        } catch {
            print(error)
        }
    }
}
