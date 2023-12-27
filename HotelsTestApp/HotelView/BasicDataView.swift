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
        ZStack {
            Color.white
            VStack(spacing: 8) {
                
                CarouselView(imageUrls: hotel.imageUrls)
                    .padding(.bottom, 8)
                HotelNameHeaderView(
                    rating: hotel.rating,
                    ratingName: hotel.ratingName,
                    hotelName: hotel.name,
                    adress: hotel.adress
                )
                .padding(.bottom, 8)
                
                PriceView(
                    price: "От \(hotel.minimalPrice) ₽",
                    pricePer: hotel.priceForIt
                )
            }
            .padding()
        }
        .clipShape(
            .rect(
                topLeadingRadius: 0,
                bottomLeadingRadius: 12,
                bottomTrailingRadius: 12,
                topTrailingRadius: 0
            )
        )
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
