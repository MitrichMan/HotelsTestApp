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
        if viewModel.imagesAreFetched {
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
            
            .onChange(of: imageUrls) {
                viewModel.fetchImages(from: imageUrls)
            }
        }
    }
    
    func getNumberOfElements() -> Int {
        if viewModel.images.count > 1 {
            return viewModel.images.count
        } else { return 1 }
    }
}

#Preview {
    CarouselView(imageUrls: ["https://deluxe.voyage/useruploads/articles/article_1eb0a64d00.jpg"])
}
