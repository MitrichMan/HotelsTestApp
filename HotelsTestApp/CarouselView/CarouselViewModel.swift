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
    
    var images: [UIImage] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    let objectWillChange = ObservableObjectPublisher()
    
    @MainActor func fetchImages(from urls: [String]) {
        Task {
//            var fetchedImages: [UIImage] = []
            for url in urls {
                guard let image = await fetchImage(from: url) else { continue }
//                fetchedImages.append(image)
                images.append(image)
            }
//            images = fetchedImages
        }
    }
    
    private func fetchImage(from url: String) async -> UIImage? {
        try? await UIImage(data: NetworkManager.shared.fetchImageData(from: url))
    }
}
