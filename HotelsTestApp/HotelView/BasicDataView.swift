//
//  BasicDataView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI
import Combine

struct BasicDataView: View {
    
    var hotel: Hotel
    
    let objectWillChange = ObservableObjectPublisher()
    
    var body: some View {
        VStack(spacing: 8) {
            
            CarouselView(imageUrls: hotel.imageUrls)
                .padding(.bottom, 8)
            
            HStack {
                TileView(
                    content: "★ \(hotel.rating) \(hotel.ratingName)",
                    foregroundColor: .mark,
                    backlgroundColor: .markBackground
                )
                
                Spacer()
            }
            
            HStack {
                Text(hotel.name)
                    .font(.system(size: 22, weight: .medium))
                    .frame(height: 26, alignment: .leading)
                
                Spacer()
            }
            
            HStack {
                Text(hotel.adress)
                    .font(.system(size: 14, weight: .medium))
                    .frame(height: 26, alignment: .leading)
                    .foregroundStyle(.blue)
                
                Spacer()
            }
            
            
            HStack(alignment: .bottom){
                Text("От \(hotel.minimalPrice) ₽")
                    .font(.system(size: 30, weight: .semibold))
                    .frame(alignment: .leading)
                
                Spacer()
                
                Text(hotel.priceForIt)
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
        
//            id: 0,
//            hotelName: "",
//            hotelAdress: "",
//            horating: 0,
//            ratingName: "",
//            departure: "",
//            arrivalCountry: "",
//            tourDateStart: "",
//            tourDateStop: "",
//            numberOfNights: 0,
//            room: "",
//            nutrition: "",
//            tourPrice: 0,
//            fuelCharge: 0,
//            serviceCharge: 0
//
        hotel: Hotel(
            id: 1,
            name: "",
            adress: "",
            minimalPrice: 1,
            priceForIt: "",
            rating: 1,
            ratingName: "",
            imageUrls: [],
            aboutTheHotel: AboutTheHotel(
                description: "", 
                peculiarities: []
            )
        )
    )
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
            .frame(alignment: .leading)
    }
}
