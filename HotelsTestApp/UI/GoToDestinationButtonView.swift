//
//  GoToDestinationButtonView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct GoToDestinationButtonView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    let text: String
    let page: Page
    
    var body: some View {
        Button(
            action: {
                if page == .hotel {
                    coordinator.popToRoot()
                } else {
                    coordinator.push(page)
                }
            },
            
            label: {
                HStack {
                    Spacer()
                    
                    Text(text)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.vertical, 6)
            }
        )
        .buttonStyle(.borderedProminent)
        .padding(.horizontal)
    }
}
