//
//  HotelView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct HotelView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = HotelViewModel()
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                    ZStack {
                        Color("Background")
                        ScrollView(.vertical) {
                            VStack(spacing: 8) {
                                
                                BasicDataView(hotel: viewModel.hotel)
                                
                                DetailedDataView(
                                    hotel: viewModel.hotel,
                                    width: geometry.size.width,
                                    buttons: viewModel.buttons
                                )
                            }
                        }
                    }
                    GoToDestinationButtonView(
                        text: "К выбору номера", 
                        page: .rooms
                    )
                    .environmentObject(coordinator)
                    .padding(.horizontal, 16)
                }
                .navigationTitle("Отель")
                .navigationBarTitleDisplayMode(.inline)
            
            .task {
                await viewModel.fetchHotel()
            }
        }
    }
}

#Preview {
    HotelView()
        .environmentObject(Coordinator())
}
