//
//  HotelDetailInfoView.swift
//  ElongHotel
//
//  Created by MC on 2020/4/28.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI

struct HotelDetailInfoView: View {
    var response: HotelDetailResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(self.response.name)
                    .font(.title)
                
                Text(self.response.starDes)
                    .font(.caption)
                
                Spacer()
            }.padding()
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text("\(self.response.comment.totalCount)条点评")
                        .font(.body)
                    
                    HStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(self.response.comment.hotelDetailPageTags) { tag in
                                    Text("\(tag.mainTagName) \(tag.commentCount)")
                                        .padding([.trailing, .leading], 5)
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.white.opacity(0.4), lineWidth: 1)
                                        )
                                }
                            }
                        }
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "chevron.right.circle")
                        }
                        .padding(.leading, 5)
                        .shadow(color: Color.white, radius: 8, x: -5, y: 0)
                        
                    }
                    .frame(height: 20)
                    .padding(.bottom, 20)

                }
                .padding([.leading], 10)
                
                Spacer()
            
                VStack {
                    Text("\(self.response.comment.CommentScore, specifier: "%.1f")分").font(.largeTitle).fontWeight(.bold).padding([.leading, .trailing], 10)

                    Text(self.response.comment.CommentDes).padding(0)
                }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.5), lineWidth: 5)
                    )
                    .padding([.bottom, .trailing], 10)
            }
        }
            .foregroundColor(.white)
            .background(
                LinearGradient(gradient: .init(colors: [.orange, .pink]),
                               startPoint: .init(x: 0, y: 0.5),
                               endPoint: .init(x: 1, y: 0.5))
            )
            .cornerRadius(12.0)
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 0)
    }
}

