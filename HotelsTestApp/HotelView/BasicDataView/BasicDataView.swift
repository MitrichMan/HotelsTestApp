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
            
            CarouselView(images: viewModel.images)
                .padding(.bottom, 8)
            
            RatingView(
                rating: viewModel.hotel.horating,
                ratingName: viewModel.hotel.ratingName
            )
            
            Text(viewModel.hotel.hotelName)
            
            }
        .padding(.horizontal, 16)
        
        .task {
            await viewModel.fetchHotel()
        }
        
    }
}

#Preview {
    BasicDataView()
}

// MARK: CarouselView
struct CarouselView: View {
    
    let images: [String]
    
    var body: some View {
        TabView {

            ForEach((0...images.count - 1), id: \.self) { index in
                HotelPhotoView(
                    images: images,
                    index: index
                )
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(height: 257)
        .cornerRadius(15)
    }
}


//MARK: RatingView
struct RatingView: View {
    let rating: Int
    let ratingName: String
    
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Color("MarkBackground")
                
                HStack(spacing: 2) {
                    Image("MarkStar")
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading, 10)
                        
                    Text("\(rating) \(ratingName)")
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

// MARK: HotelPhotoView
struct HotelPhotoView: View {
    let images: [String]
    var index: Int
    
    var body: some View {
        Image(images[index])
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
