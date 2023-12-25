//
//  BookingView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct BookingView: View {
    @StateObject var viewModel = BookingViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(.background)
                VStack {
                    HotelNameHeaderView(
                        rating: viewModel.bookingData.horating,
                        ratingName: viewModel.bookingData.ratingName,
                        hotelName: viewModel.bookingData.hotelName,
                        adress: viewModel.bookingData.hotelAdress
                    )
                    
                    ZStack {
                        Color.white
                        LazyVGrid(
                            columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], 
                            content: {
//                                ForEach(0...) { index in
//                                    <#code#>
//                                }
                        }
                        )
                    }
                }
            }
        }
        .navigationTitle("Бронирование")
        .task {
            await viewModel.fetchBookingData()
        }
    }
}

#Preview {
    BookingView()
}

struct HotelNameHeaderView: View {
    let rating: Int
    let ratingName: String
    let hotelName: String
    let adress: String
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                HStack {
                    TileView(
                        content: Text("★ \(rating) \(ratingName)"),
                        foregroundColor: .mark,
                        backlgroundColor: .markBackground
                    )
                    
                    Spacer()
                }
                
                HStack {
                    Text(hotelName)
                        .font(.system(size: 22, weight: .medium))
                        .frame(alignment: .leading)
                    
                    Spacer()
                }
                
                HStack {
                    Text(adress)
                        .font(.system(size: 14, weight: .medium))
                        .frame(height: 26, alignment: .leading)
                        .foregroundStyle(.blue)
                    
                    Spacer()
                }
            }
        }
        .cornerRadius(12)
    }
}
