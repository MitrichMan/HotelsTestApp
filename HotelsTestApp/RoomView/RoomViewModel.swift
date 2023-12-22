//
//  RoomViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation

class RoomViewModel: ObservableObject {
    @Published var rooms = Rooms(rooms: [])
    
    @MainActor func fetchHotel() async {
        do {
            rooms = try await NetworkManager.shared.fetchRooms()
        } catch {
            print(error)
        }
    }
}
