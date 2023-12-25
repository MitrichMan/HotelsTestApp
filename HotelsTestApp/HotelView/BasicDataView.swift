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
            HotelNameHeaderView(
                rating: hotel.rating,
                ratingName: hotel.ratingName,
                hotelName: hotel.name,
                adress: hotel.adress
            )
//            HStack {
//                TileView(
//                    content: Text("★ \(hotel.rating) \(hotel.ratingName)"),
//                    foregroundColor: .mark,
//                    backlgroundColor: .markBackground
//                )
//                
//                Spacer()
//            }
//            
//            HStack {
//                Text(hotel.name)
//                    .font(.system(size: 22, weight: .medium))
//                    .frame(alignment: .leading)
//                
//                Spacer()
//            }
//            
//            HStack {
//                Text(hotel.adress)
//                    .font(.system(size: 14, weight: .medium))
//                    .frame(height: 26, alignment: .leading)
//                    .foregroundStyle(.blue)
//                
//                Spacer()
//            }
            .padding(.bottom, 8)
            
            
            PriceView(
                price: "От \(hotel.minimalPrice) ₽",
                pricePer: hotel.priceForIt
            )
        }
        .padding(.top)
    }
}

#Preview {
    BasicDataView(
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
    let content: Text
    let foregroundColor: Color
    let backlgroundColor: Color
    
    var body: some View {
        Text("\(content)")
            .font(.system(size: 16, weight: .medium))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .foregroundStyle(foregroundColor)
            .background(backlgroundColor)
            .frame(alignment: .leading)
            .cornerRadius(5)
    }
}

struct PriceView: View {
    let price: String
    let pricePer: String
    
    var body: some View {
        HStack(alignment: .bottom){
            Text("\(price)")
                .font(.system(size: 30, weight: .semibold))
                .frame(alignment: .leading)
            
            Text(pricePer)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.gray)
            
            Spacer()
        }
    }
}
