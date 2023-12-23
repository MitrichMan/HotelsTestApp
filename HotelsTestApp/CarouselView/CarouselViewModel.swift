//
//  CarouselViewModel.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 22.12.2023.
//

import Foundation
import UIKit
import Combine

class CarouselViewModel: ObservableObject {
    
    @Published var images: [UIImage] = []
    
    @Published var count = 0 {
        didSet {
            imagesAreFetched = true
            objectWillChange.send()
        }
    }
    
    @Published var imagesAreFetched = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    let objectWillChange = ObservableObjectPublisher()
    
    @MainActor func fetchImages(from urls: [String]) {
        Task {
            var fetchedImages: [UIImage] = []
            for url in urls {
                guard let image = await fetchImage(from: url) else { return }
                fetchedImages.append(image)
            }
            images = fetchedImages
            count = images.count
        }
    }
    
    private func fetchImage(from url: String) async -> UIImage? {
        try? await UIImage(data: NetworkManager.shared.fetchImageData(from: url))
    }
}
