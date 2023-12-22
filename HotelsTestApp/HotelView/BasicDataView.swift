//
//  BasicDataView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct BasicDataView: View {
    
    var hotel: Hotel
    var images: [String]
    var totalPrice: Int
    
    var body: some View {
        VStack(spacing: 8) {
            
//            Text("Отель")
//                .font(.system(size: 18, weight: .medium))
//            
            CarouselView(images: images)
                .padding(.bottom, 8)
            
            HStack {
                TileView(
                    content: "★ \(hotel.horating) \(hotel.ratingName)",
                    foregroundColor: .mark,
                    backlgroundColor: .markBackground
                )
                
                Spacer()
            }
            
            HStack {
                Text(hotel.hotelName)
                    .font(.system(size: 22, weight: .medium))
                    .frame(height: 26, alignment: .leading)
                
                Spacer()
            }
            
            HStack {
                Text(hotel.hotelAdress)
                    .font(.system(size: 14, weight: .medium))
                    .frame(height: 26, alignment: .leading)
                    .foregroundStyle(.blue)
                
                Spacer()
            }
            
            
            HStack(alignment: .bottom){
                Text("От \(totalPrice) ₽")
                    .font(.system(size: 30, weight: .semibold))
                    .frame(alignment: .leading)
                
                Spacer()
                
                Text("за тур с перелетом")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.gray)
                    .frame(alignment: .trailing)
            }
        }
        .padding(.top)
    }
}

#Preview {
    BasicDataView(
        hotel: Hotel(
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
            fuelCharge: 0,
            serviceCharge: 0
        ),
        images: [
            "Image1",
            "Image2",
            "Image3",
            "Image4",
            "Image5"
        ], totalPrice: 100
    )
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


//MARK: TileView
struct TileView: View {
    let content: String
    let foregroundColor: Color
    let backlgroundColor: Color
    
    
    var body: some View {
        Text("\(content)")
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, 10)
            .background(backlgroundColor)
            .cornerRadius(5)
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
