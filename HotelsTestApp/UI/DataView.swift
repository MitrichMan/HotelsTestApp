//
//  DataView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct DataView: View {
    var data: [DataViewData]
    let presentationMode: PresentationMode
    
    let columns = [
        GridItem(.flexible(
            minimum: 0,
            maximum: 140)
                 
        ),
        GridItem(.flexible(
            minimum: 0,
            maximum: 203)
        )
    ]
    
    var body: some View {
        ZStack {
            Color.white
            LazyVGrid(
                columns: [
                    GridItem(.flexible(
                        minimum: 0,
                        maximum: 140
                    )),
                    GridItem(.flexible(
                        minimum: 0,
                        maximum: 203
                    ))
                ],
                alignment: .leading,
                spacing: 8,
                content: {
                    ForEach(data, id: \.self) { data in
                        
                        Text(data.title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.gray)
                        
                        HStack {
                            if presentationMode == .wide {
                                Spacer()
                                
                                Text(data.subtitle)
                                    .frame(alignment: .trailing)
                            } else {
                                Text(data.subtitle)
                                    .frame(alignment: .leading)
                                
                                Spacer()
                            }
                        }
                    }
                }
            )
            .padding()
        }
        .cornerRadius(12)
    }
}
