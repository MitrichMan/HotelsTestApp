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
                
                PeculiaritiesTilesView(
                    peculiarities: hotel.aboutTheHotel.peculiarities,
                    foregroundColor: Color(.peculiarities),
                    backgroundColor: Color(.peculiaritiesBackground)
                )
                
                .frame(
                    height:
                        hotel.aboutTheHotel.peculiarities.count <= 2 ? 32 : 64
                )
                
                Text(hotel.aboutTheHotel.description)
                    .font(.system(size: 16))
                
                ButtonsView(buttons: buttons)
            }
//            .padding()
        }
        .cornerRadius(12)
    }
}

// MARK: Preview
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
    var peculiarities: [String]
    let foregroundColor: Color
    let backgroundColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(
                columns: [
                    GridItem(.flexible(
                        minimum: 0,
                        maximum: geometry.size.width)
                    ),
                    GridItem(.flexible(
                        minimum: 0,
                        maximum: geometry.size.width)
                    )
                ],
                alignment: .leading,
                spacing: 8,
                content: {
                    ForEach(peculiarities, id: \.self) { peculiarity in
                        TileView(
                            content: Text(peculiarity),
                            foregroundColor: foregroundColor,
                            backlgroundColor: backgroundColor
                        )
                        .frame(
                            minWidth: 0,
                            maxWidth: geometry.size.width / 2 - 4
                        )
                        .fixedSize(horizontal: true, vertical: false)
                    }
                }
            )
        }
    }
}
