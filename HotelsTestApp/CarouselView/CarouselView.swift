//
//  CarouselView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 22.12.2023.
//

import SwiftUI

struct CarouselView: View {
    @StateObject private var viewModel = CarouselViewModel()
    
    var imageUrls: [String]
    
    var body: some View {
        if !viewModel.images.isEmpty {
            TabView {
                ForEach(viewModel.images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .id(viewModel.images.count)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            .frame(height: 257)
            .cornerRadius(15)
            
            .padding(.top)
            .padding(.horizontal)
            
            .onChange(of: imageUrls) {
                viewModel.fetchImages(from: imageUrls)
            }
            
        } else {
            ZStack{
                Color(.background)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            .frame(height: 257)
            .cornerRadius(15)
            .padding(.top)
            .padding(.horizontal)
            
                        .onAppear(perform:  {
            viewModel.fetchImages(from: imageUrls)
        })
            .onChange(of: imageUrls) {
                viewModel.fetchImages(from: imageUrls)
            }
        }
    }
}

#Preview {
    CarouselView(imageUrls: [
        "https://deluxe.voyage/useruploads/articles/article_1eb0a64d00.jpg"
    ])
}
