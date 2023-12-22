//
//  DetailedDataView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct DetailedDataView: View {
    
    let hotel: Hotel

    let buttons: [HotelButton]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            HStack {
                Text("Об отеле")
                    .font(.system(size: 22, weight: .medium))
                
                Spacer()
            }
            
            PeculiaritiesTilesView()
            
            Text("Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!")
                .font(.system(size: 16))
            
            ButtonsView(buttons: buttons)
        }
    }
}

// MARK: Preview
#Preview {
    DetailedDataView(
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
    let foregroundColor = Color(.peculiarities)
    let backgroundColor = Color(.peculiaritiesBackground)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TileView(
                    content: "3-я линия",
                    foregroundColor: foregroundColor,
                    backlgroundColor: backgroundColor
                )
                
                TileView(
                    content: "Платный Wi-Fi в фойе",
                    foregroundColor: foregroundColor,
                    backlgroundColor: backgroundColor
                )
            }
            
            HStack {
                TileView(
                    content: "30 км до аэропорта",
                    foregroundColor: foregroundColor,
                    backlgroundColor: backgroundColor
                )
                
                TileView(
                    content: "1 км до пляжа",
                    foregroundColor: foregroundColor,
                    backlgroundColor: backgroundColor
                )
            }
        }
    }
}
