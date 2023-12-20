//
//  HotelView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 19.12.2023.
//

import SwiftUI

struct HotelView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            BasicDataView()
        }
    }
}

#Preview {
    HotelView()
}
