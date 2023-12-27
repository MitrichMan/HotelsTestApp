//
//  Coordinator.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI
//import Combine

@MainActor class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath() 
//    {
//        didSet {
//            objectWillChange.send()
//        }
//    }
    
//    let objectWillChange = ObservableObjectPublisher()
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder func build(page: Page) -> some View {
        switch page {
        case .hotel:
            HotelView()
        case .rooms:
            RoomsView()
        case .booking:
            BookingView()
        case .success:
            SuccessView()
        }
    }
}
    
enum Page: String {
    case hotel
    case rooms
    case booking
    case success
}
