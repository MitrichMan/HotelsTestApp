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
        ZStack {
            Color("Background")
            
            ScrollView(.vertical) {
                
                VStack(spacing: 8) {
                    
                    ZStack {
                        Color(.white)
                        
                        BasicDataView(
                            hotel: viewModel.hotel,
                            images: viewModel.images,
                            totalPrice: viewModel.totalPrice
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom)
                    }
                    .cornerRadius(30)
                    
                    ZStack {
                        Color(.white)
                        DetailedDataView()
                    }
                }
            }
            .task {
                await viewModel.fetchHotel()
            }
        }
    }
}

#Preview {
    HotelView()
}
