//
//  HotelDetailNearView.swift
//  ElongHotel
//
//  Created by MC on 2020/5/4.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HotelDetailNearView: View {
    var near: HotelDetailNear
    @State private var grid: [Int] = [Int]()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("相似酒店推荐")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack {
                    Text("\(self.near.SurroundRecomHotelNum)家")
                        .font(.subheadline)
                        .foregroundColor(Color("themeColor"))
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(10)
            
            /// 酒店
            VStack(alignment: .leading, spacing: 20) {
                ForEach(self.grid, id: \.self) { i in
                    HStack {
                        ForEach(i...i+1, id: \.self) { j in
                            VStack {
                                if j != self.near.HotelList.count {
                                    HotelCell(hotel: self.near.HotelList[j])
                                } else {
                                    HotelCell(hotel: self.near.HotelList[j - 1])
                                        .hidden()
                                }
                            }
                        }
                    }
                }
            }
            .padding([.leading, .trailing, .bottom], 10)
        }
        .background(Color.white)
        .cornerRadius(12)
        .padding([.top, .leading, .trailing], 10)
        .onAppear {
            for i in stride(from: 0, to: self.near.HotelList.count, by: 2) {
                
                self.grid.append(i)
            }
            print(self.grid)
        }
    }
}

struct HotelCell: View {
    var hotel: Hotel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            WebImage(url: URL(string: hotel.PicUrl))
                .resizable()
                .scaledToFill()
                .animation(.easeInOut(duration: 0.5))
                .frame(height: 100)
                .cornerRadius(6)
                .padding(0)
            
            Text(hotel.HotelName)
                .font(.subheadline)
                .lineLimit(1)
            
            HStack(spacing: 5) {
                Text("\(hotel.commentScore, specifier: "%.1f")分")
                    .font(.subheadline)
                    .foregroundColor(Color("themeColor"))
                
                Text("距离酒店\(Double(hotel.Distance) / 1000.0, specifier: "%.1f")公里")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
             HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("¥")
                       .font(.subheadline)
                       
                    Text("\(hotel.LowestPrice)")
            
                
                    Text("起").font(.caption).foregroundColor(.secondary)
                       
               }
               .foregroundColor(Color("redColor"))
            
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: "hand.thumbsup.fill")
                    .font(.system(size: 8))
                    .padding(.leading, 4)
                
                Text("近距离酒店推荐")
                    .font(.caption)
                    .padding(.trailing, 4)
            }
            .foregroundColor(.green)
            .background(Color.green.opacity(0.2))
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.green.opacity(0.5), lineWidth: 0.5)
            )
        }
    }
}
