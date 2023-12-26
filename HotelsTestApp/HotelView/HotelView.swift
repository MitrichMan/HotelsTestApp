//
//  HotelView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct HotelView: View {
    @StateObject private var viewModel = HotelViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    ZStack {
                        Color("Background")
                        
                        VStack {
                            ScrollView(.vertical) {
                                VStack(spacing: 8) {
                                    ZStack {
                                        Color(.white)
                                        
                                        BasicDataView(hotel: viewModel.hotel)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom)
                                        
                                    }
                                    .clipShape(
                                        .rect(
                                            topLeadingRadius: 0,
                                            bottomLeadingRadius: 12,
                                            bottomTrailingRadius: 12,
                                            topTrailingRadius: 0
                                        )
                                    )
                                    
                                    ZStack {
                                        Color(.white)
                                        DetailedDataView(
                                            hotel: viewModel.hotel,
                                            width: geometry.size.width,
                                            buttons: viewModel.buttons
                                        )
                                        .padding()
                                    }
                                    .cornerRadius(12)
                                    .padding(.bottom, 16)
                                }
                            }
                            
                        }
                    }
                    
                    GoToDestinationButtonView(
                        destination: RoomsView(),
                        text: "К выбору номера"
                    )
                        .padding(.horizontal, 16)
                }
                .navigationBarTitle("Отель")
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationBarBackButtonHidden()
            
            .task {
                await viewModel.fetchHotel()
            }
        }
    }
}

#Preview {
    HotelView()
}

struct GoToDestinationButtonView: View {
    let destination: any View
    let text: String
    
    var body: some View {
        NavigationLink {
            AnyView(destination)
        } label: {
            HStack {
                Spacer()
                
                Text(text)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.vertical, 6)
        }
        .buttonStyle(.borderedProminent)
        .font(.system(size: 16, weight: .medium))
        .foregroundColor(.white)
    }
}
