//
//  BasicDataView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct BasicDataView: View {
    @StateObject private var viewModel = BasicDataViewModel()
    private let mokHotel = Hotel(
        id: 1,
        hotelName: "2",
        hotelAdress: "3",
        horating: 4,
        ratingName: "5",
        departure: "6",
        arrivalCountry: "7",
        tourDateStart: "8",
        tourDateStop: "9",
        numberOfNights: 10,
        room: "11",
        nutrition: "12",
        tourPrice: 13,
        fuelPrice: 14,
        serviceCharge: 15
    )
    
    private let mokPhotos = ["Image1", "Image2", "Image3", "Image4", "Image5"]
    
    var body: some View {
        VStack {
            Text("Отель")
                .font(.system(size: 18, weight: .medium))
            ScrollView(.horizontal) {
                HStack {
                    ForEach((0...mokPhotos.count - 1), id: \.self) { index in
                        Image(mokPhotos[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 343, height: 257)
                    }
                }
            }.padding(.horizontal, 16)
        }
        
        
    }
}


#Preview {
    BasicDataView()
}
