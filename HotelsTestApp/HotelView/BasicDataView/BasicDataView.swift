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
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            Text("Отель")
                .font(.system(size: 18, weight: .medium))
            
            CarouselView()
                .padding(.bottom, 8)
            
                MarkView()
            
            Text(mokHotel.hotelName)
            
            }
        .padding(.horizontal, 16)
    }
}

#Preview {
    BasicDataView()
}

struct CarouselView: View {
    
    private let mokPhotos = ["Image1", "Image2", "Image3", "Image4", "Image5"]

    var body: some View {
        TabView {

            ForEach((0...mokPhotos.count - 1), id: \.self) { index in
                Image(mokPhotos[index])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(height: 257)
        .cornerRadius(15)
    }
}

struct MarkView: View {
    var body: some View {
        HStack {
            ZStack {
                Color("MarkBackground")
                
                HStack(spacing: 2) {
                    Image("MarkStar")
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                        .aspectRatio(contentMode: .fit)
                        
                    Text("5 Превосходно")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.mark)
                }
            }
            .frame(width: 149, height: 29)
            .cornerRadius(5)
            
            Spacer()
        }
    }
}
