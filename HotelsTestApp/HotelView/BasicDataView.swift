//
//  BasicDataView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct BasicDataView: View {
    
    var hotel: Hotel
        
    var body: some View {
        ZStack {
            Color.white
            VStack(alignment: .leading, spacing: 0) {
                
                CarouselView(imageUrls: hotel.imageUrls)
                    .padding()
                
                HotelNameHeaderView(
                    rating: hotel.rating,
                    ratingName: hotel.ratingName,
                    hotelName: hotel.name,
                    adress: hotel.adress
                )
                .padding()
                
                PriceView(
                    price: "От \(hotel.minimalPrice) ₽",
                    pricePer: hotel.priceForIt
                )
                .padding()
            }
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
