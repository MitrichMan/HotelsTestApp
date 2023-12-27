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
                                    data: viewModel.prepareBookingDataViewData(
                                        names: viewModel.bookingDataNames
                                    )
                                )
                                
                                CustomerInfoView(phone: $viewModel.customerData.phone, email: $viewModel.customerData.email)
                                
                                TouristDataView(tourists: $viewModel.tourists)
                                
                                AddTouristView(action: viewModel.addTourist)
                                
                                DataView(
                                    data: viewModel.prepareBookingDataViewData(
                                        names: viewModel.finalPriceNames
                                    )
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

struct HotelNameHeaderView: View {
    let rating: Int
    let ratingName: String
    let hotelName: String
    let adress: String
    
    var body: some View {
        ZStack {
            Color.white
            HStack {
                VStack(alignment: .leading) {
                    TileView(
                        content: Text("★ \(rating) \(ratingName)"),
                        foregroundColor: .mark,
                        backlgroundColor: .markBackground
                    )
                    
                    Text(hotelName)
                        .font(.system(size: 22, weight: .medium))
                        .frame(alignment: .leading)
                    
                    Text(adress)
                        .font(.system(size: 14, weight: .medium))
                        .frame(height: 26, alignment: .leading)
                        .foregroundStyle(.blue)
                    
                }
//                .padding()
                Spacer()
            }
        }
        .cornerRadius(12)
        .padding(.top, 8)
    }
}

struct DataTextFieldView: View {
    let fieldName: String
    @Binding var text: String
    
    var body: some View {
        ZStack {
            Color.background
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(fieldName)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                TextField("00000000", text: $text)
                    .keyboardType(.phonePad)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
        }
        .frame(height: 52)
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.top, 16)
    }
}







