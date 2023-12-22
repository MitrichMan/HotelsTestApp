//
//  RoomViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation

class RoomViewModel: ObservableObject {
    @Published var rooms = Rooms(rooms: [])
    @Published var roomImages: [Data] = []
    
    @MainActor func fetchRooms() async {
        do {
            rooms = try await NetworkManager.shared.fetchRooms()
        } catch {
            print(error)
        }
    }
    
    func fetchImages(from urls: [String])  {
        do {
            for url in urls {
                let roomImage = try NetworkManager.shared.fetchImageData(from: url)
                roomImages.append(roomImage)
            }
        } catch {
            print(error)
        }
    }
}
