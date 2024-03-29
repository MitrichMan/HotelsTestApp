//
//  BookingView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct BookingView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var viewModel = BookingViewModel()
    
    var body: some View {
            VStack {
                ZStack{
                    Color.background
                        VStack {
                            ScrollView {
                                HotelNameHeaderView(
                                    rating: viewModel.bookingData.horating,
                                    ratingName: viewModel.bookingData.ratingName,
                                    hotelName: viewModel.bookingData.hotelName,
                                    adress: viewModel.bookingData.hotelAdress
                                )
                                                                
                                DataView(
                                    data: viewModel.hotelData,
                                    presentationMode: .narrow
                                )
                                
                                CustomerInfoView(
                                    phone: $viewModel.customer.phone,
                                    email: $viewModel.customer.email
                                )
                                
                                TouristDataView(tourists: $viewModel.tourists)
                                
                                
                                AddTouristView(action: viewModel.addTourist)
                                
                                DataView(
                                    data: viewModel.priceData,
                                    presentationMode: .wide
                                )
                            }
                        }
                }
                
                GoToDestinationButtonView(
                    text: "Оплатить \(viewModel.bookingData.tourPrice + viewModel.bookingData.fuelCharge + viewModel.bookingData.serviceCharge)",
                    page: .success
                )
                .padding(.horizontal)
            }
            .navigationTitle("Бронирование")
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: Button(action: {
                coordinator.pop()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }))
    
        .task {
            await viewModel.fetchBookingData()
        }
    }
}

#Preview {
    BookingView()
}
