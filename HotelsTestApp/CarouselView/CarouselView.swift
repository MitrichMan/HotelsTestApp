//
//  CarouselView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 22.12.2023.
//

import SwiftUI

struct CarouselView: View {
    
    let images: [String]

    var body: some View {
        TabView {
            ForEach((0...images.count - 1), id: \.self) { index in
                Image(images[index])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(height: 257)
        .cornerRadius(15)
    }
}

#Preview {
    CarouselView(images: DataManager.shared.images)
}

