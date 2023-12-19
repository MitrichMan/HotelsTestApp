//
//  Rooms.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import Foundation

struct Rooms {
    let rooms: [Room]
}

struct Room {
    let id: Int
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: String
    let imageUrls: [String]
}
