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
//        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 16){
                HStack {
                    Text("Об отеле")
                        .font(.system(size: 22, weight: .medium))
                    
                    Spacer()
                }
                
                PeculiaritiesTilesView(hotel: hotel, width: width)
                
                Text(hotel.aboutTheHotel.description)
                    .font(.system(size: 16))
                
                ButtonsView(buttons: buttons)
            }
//        }
    }
}

// MARK: Preview
#Preview {
    DetailedDataView(
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

// MARK: ButtonsView
struct ButtonsView: View {
    let buttons: [HotelButton]
    
    var body: some View {
        ZStack {
            Color(.peculiaritiesBackground)
            VStack {
                ForEach((0...buttons.count - 1), id: \.self) { index in
                    HStack {
                        Image(buttons[index].image)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .offset(y: -5)
                        VStack {
                            ListRowView(
                                image: buttons[index].image,
                                title: buttons[index].title,
                                subTitle: buttons[index].subTitle
                            )
                            if index != buttons.count - 1 {
                                Divider()
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 16)
        }
        .cornerRadius(15)
    }
}

// MARK: ListRowView
struct ListRowView: View {
    let image: String
    let title: String
    let subTitle: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                Text(subTitle)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
                
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

// MARK: PeculiaritiesTilesView
struct PeculiaritiesTilesView: View {
    
    var hotel: Hotel
    let width: CGFloat
    
    let foregroundColor = Color(.peculiarities)
    let backgroundColor = Color(.peculiaritiesBackground)
    
    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(minimum: 0, maximum: width - 32)),
                GridItem(.flexible(minimum: 0, maximum: width - 32))
            ],
            alignment: .leading,
            spacing: 8,
            content: {
                ForEach(hotel.aboutTheHotel.peculiarities, id: \.self) { peculiarity in
                    
                    TileView(
                        content: peculiarity,
                        foregroundColor: foregroundColor,
                        backlgroundColor: backgroundColor,
                        textSize: 16
                    )
                    .frame(minWidth: 0, maxWidth: width / 2 - 20)
                    .fixedSize(horizontal: true, vertical: false)
                }
            }
        )
    }
}
