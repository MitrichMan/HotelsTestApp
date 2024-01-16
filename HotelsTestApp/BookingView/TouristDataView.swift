//
//  TouristDataView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct TouristDataView: View {
    @Binding var tourists: [Tourist]
    
    var body: some View {
        VStack {
            ForEach(
                0..<tourists.count,
                id: \.self
            ) { index in
                ZStack {
                    Color.white
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .bottom) {
                            Text("\(index + 1) турист")
                                .font(.system(size: 22, weight: .medium))
                                .padding(.top)
                            
                            Spacer()
                            Button {
                                tourists[index].isPresented.toggle()
                            } label: {
                                Image(
                                    systemName: tourists[index].isPresented
                                      ? "chevron.up"
                                      : "chevron.down"
                                )
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 7)
                                    .fontWeight(.medium)
                                    .font(.system(size: 22))
                                    .foregroundColor(.aboutTheRoomForeground)
                                    .background(.aboutTheRoomBackground)
                                    .cornerRadius(6)
                            }

                        }
                        .padding(.horizontal)
                        
                        if tourists[index].isPresented {
                            ForEach(
                                DataManager.shared.touristDataFieldNames,
                                id: \.self
                            ) { name in
                                
                                DataTextFieldView(
                                    text:
                                        DataManager.shared.prepareTouristData(
                                            name: name,
                                            data: tourists[index]
                                    ),
                                    fieldName: name.rawValue, 
                                    fieldFormat: .string
                                )
                            }
                        }
                    }
                    .padding(.bottom)
                }
                .cornerRadius(12)
            }
        }
        .padding(.bottom)
    }
}
