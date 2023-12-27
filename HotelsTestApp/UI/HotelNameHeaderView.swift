//
//  HotelNameHeaderView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct HotelNameHeaderView: View {
    let rating: Int
    let ratingName: String
    let hotelName: String
    let adress: String
    
    var body: some View {
        ZStack {
            Color.white
            HStack {
                VStack(alignment: .leading, spacing: 16) {
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
                        .frame(height: 16, alignment: .leading)
                        .foregroundStyle(.blue)
                    
                }
                Spacer()
            }
            .padding()
        }
        .cornerRadius(12)
    }
}
