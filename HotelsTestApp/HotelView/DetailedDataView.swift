//
//  DetailedDataView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct DetailedDataView: View {
    
    let hotel: Hotel
    let width: CGFloat
    
    let buttons: [HotelButton]
    
    var body: some View {
        ZStack {
            Color.white
            VStack(alignment: .leading, spacing: 16){
                HStack {
                    Text("Об отеле")
                        .font(.system(size: 22, weight: .medium))
                    
                    Spacer()
                }
                
                
                
                HStack {
                    TileStackView(
                        content: hotel.aboutTheHotel.peculiarities,
                        foregroundColor: Color(.peculiarities),
                        backgroundColor: Color(.peculiaritiesBackground)
                    )
                    .frame(
                        height:
                            hotel.aboutTheHotel.peculiarities.count <= 2 ? 32 : 64
                    )
                    
                    Spacer()
                }
                
                Text(hotel.aboutTheHotel.description)
                    .font(.system(size: 16))
                
                TableWithButtonsView(buttons: buttons)
            }
            .padding()
        }
        .cornerRadius(12)
    }
}

#Preview {
    DetailedDataView(
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
        ), width: 250,
        buttons: DataManager.shared.buttons
    )
}


