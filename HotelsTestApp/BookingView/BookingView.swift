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
                Color.background
                HStack {
                    ScrollView {
                        HotelNameHeaderView(
                            rating: viewModel.bookingData.horating,
                            ratingName: viewModel.bookingData.ratingName,
                            hotelName: viewModel.bookingData.hotelName,
                            adress: viewModel.bookingData.hotelAdress
                        )
                        
                        BookingDataView(bookingData: viewModel.bookingData)
                        
                        CustomerInfoView(phone: $viewModel.customerData.phone, email: $viewModel.customerData.email)
                        
                        ZStack {
                            Color.white
                            VStack {
                                ForEach(
                                    0..<viewModel.tourists.count,
                                    id: \.self
                                ) { index in
                                    ForEach(
                                        DataManager.shared.touristDataFieldNames,
                                        id: \.self
                                    ) { name in
                                        
                                        DataTextFieldView(
                                            fieldName: name.rawValue,
                                            text: .constant(DataManager.shared.prepareTouristData(
                                                name: name,
                                                data: viewModel.tourists[index]
                                            ))
                                        )
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
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
                Spacer()
            }
            .padding()
        }
        .cornerRadius(12)
        .padding(.top, 8)
    }
}
    
struct BookingDataView: View {
    let bookingData: BookingData
    
    
    var body: some View {
        ZStack {
            Color.white
            LazyVGrid(
                columns: [
                    GridItem(.flexible(
                        minimum: 0,
                        maximum: 140)
                    ),
                    GridItem(.flexible(
                        minimum: 0,
                        maximum: 203)
                    )
                ],
                alignment: .leading,
                spacing: 8,
                content: {
                    ForEach(
                        DataManager.shared.bookingDataNames,
                        id: \.self
                    ) { name in
                        
                        
                        Text(name.rawValue)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.gray)
                        
                        Text(DataManager.shared.prepareBookingData(
                            name: name,
                            data: bookingData
                        ))
                    }
                }
            )
            .padding()
        }
        .cornerRadius(12)
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

struct CustomerInfoView: View {
    @Binding var phone: String
    @Binding var email: String
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Информация о покупателе")
                    .font(.system(size: 22, weight: .medium))
                    .padding(.horizontal)
                    .padding(.top)
                
                DataTextFieldView(
                    fieldName: "Номер телефона",
                    text: $phone
                )
                
                DataTextFieldView(
                    fieldName: "Почта",
                    text: $email
                )
                
                Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                    .padding(.vertical)
            }
        }
        .cornerRadius(12)
    }
}

