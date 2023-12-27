//
//  AddTouristView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct AddTouristView: View {
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.white
            HStack {
                Text("Добавить туриста")
                    .font(.system(size: 22, weight: .medium))
                
                Spacer()
                
                Button(
                    action: {
                        action()
                    },
                    label: {
                        Image(systemName: "plus")
                            .frame(width: 24, height: 24)
                    }
                )
                .frame(width: 32, height: 32)
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
