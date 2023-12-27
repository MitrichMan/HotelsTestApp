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

struct DataView: View {
    var data: [DataViewData]
    
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
                    ForEach(data, id: \.self) { data in
                            
                        Text(data.title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.gray)
                                            
                        Text(data.subtitle)
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


struct TouristDataView: View {
    @Binding var tourists: [Tourist]
    
    var body: some View {
        VStack {
            ForEach(
                0..<tourists.count,
                id: \.self
            ) { index in
                ZStack {
                    Color.white
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .bottom) {
                            Text("\(index + 1) турист")
                                .font(.system(size: 22, weight: .medium))
                                .padding(.top)
                            
                            Spacer()
                            Button {
                                tourists[index].isPresented.toggle()
                            } label: {
                                Image(
                                    systemName: tourists[index].isPresented
                                      ? "chevron.up"
                                      : "chevron.down"
                                )
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 7)
                                    .fontWeight(.medium)
                                    .font(.system(size: 22))
                                    .foregroundColor(.aboutTheRoomForeground)
                                    .background(.aboutTheRoomBackground)
                                    .cornerRadius(6)
                            }

                        }
                        .padding(.horizontal)
                        
                        if tourists[index].isPresented {
                            ForEach(
                                DataManager.shared.touristDataFieldNames,
                                id: \.self
                            ) { name in
                                
                                DataTextFieldView(
                                    fieldName: name.rawValue,
                                    text: .constant(DataManager.shared.prepareTouristData(
                                        name: name,
                                        data: tourists[index]
                                    ))
                                )
                            }
                        }
                        //jknbnmnb
                        
                    }
                    .padding(.bottom)
                }
                .cornerRadius(12)
            }
        }
        .padding(.bottom)
    }
}

struct AddTouristView: View {
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.white
            HStack {
                Text("Добавить туриста")
                    .font(.system(size: 22, weight: .medium))
                
                Spacer()
                
                Button(
                    action: {
                        action()
                    },
                    label: {
                        Image(systemName: "plus")
                            .frame(width: 24, height: 24)
                    }
                )
                .frame(width: 32, height: 32)
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
