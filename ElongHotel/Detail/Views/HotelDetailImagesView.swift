//
//  HotelDetailImagesView.swift
//  ElongHotel
//
//  Created by MC on 2020/4/22.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HotelDetailImagesView: View {
    var imageItems: [HotelDetailImageItem]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    ForEach(self.imageItems) { item in
                        WebImage(url: URL(string: item.ImageUrl))
                            .resizable()
                            .scaledToFit()
                            .animation(.easeInOut(duration: 0.5))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.5), radius: 3, x: 5, y: 5)
                            .shadow(color: Color.white.opacity(0.5), radius: 3, x: 5, y: 5)
                            .frame(width: 300, height: 200)
                    }
                    
                    Button(action: {
                        
                    }) {
                       Text("查看更多图片")
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing], 30)
                        .padding([.top, .bottom], 20)
                    }
                    .buttonStyle(CustomButton())
                    .padding()

                }
                .padding([.leading, .trailing], 10)

            }
        }
    }
}

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color("buttonColor"))
            .cornerRadius(15)
            .overlay(
                VStack {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black.opacity(0.05), lineWidth: 4)
                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 5, y: 5)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
            )
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0 : 0.2), radius: 3, x: 5, y: 5)
            .shadow(color: Color.white.opacity(configuration.isPressed ? 0 : 0.55), radius: 3, x: 5, y: 5)
    }
}
