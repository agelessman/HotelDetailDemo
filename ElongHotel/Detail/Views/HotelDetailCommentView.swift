//
//  HotelDetailCommentView.swift
//  ElongHotel
//
//  Created by MC on 2020/5/3.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI

struct HotelDetailCommentView: View {
    var comment: HotelUserComment
    
    static let commentLenght: Double = 60
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(comment.moduleTitle)
                    .font(.headline)
                
                Spacer()
                
                HStack {
                    Text(comment.totalCountTip)
                        .font(.subheadline)
                        .foregroundColor(Color("themeColor"))
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding([.top, .leading, .trailing], 10)
            
            HStack {
                HStack(alignment: .firstTextBaseline, spacing: 5) {
                    Text("\(self.comment.hotelUserCommentInfo.commentScore.score, specifier: "%.1f")")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(self.comment.hotelUserCommentInfo.commentScore.commentDes)
                        .font(.caption)
                }
                .foregroundColor(Color("themeColor"))
                .padding(.leading, 10)
                
                Spacer()
                
                HStack {
                    VStack(spacing: 4) {
                        getCommentProgress("位置", score: self.comment.hotelUserCommentInfo.commentScore.positionScore)
                        
                        getCommentProgress("服务", score: self.comment.hotelUserCommentInfo.commentScore.serviceScore)
                    }
                    
                    VStack(spacing: 4) {
                        getCommentProgress("设施", score: self.comment.hotelUserCommentInfo.commentScore.facilityScore)
                        
                        getCommentProgress("卫生", score: self.comment.hotelUserCommentInfo.commentScore.sanitationScore)
                    }
                }
                .padding(10)
            }
            .background(Color("grayBgColor"))
            .cornerRadius(3)
            .padding([.top, .leading, .trailing], 10)
        
            /// 个人头像
            HStack {
                Text("\(self.getFirstC(self.comment.hotelUserCommentInfo.userName))")
                    .padding(5)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(self.comment.hotelUserCommentInfo.userName)
                            .foregroundColor(.black)
                            .font(.subheadline)
                        
                        Text(self.comment.hotelUserCommentInfo.travelTypeDesc)
                            .foregroundColor(.secondary)
                            .font(.caption)
                            .padding([.leading, .trailing], 8)
                            .padding([.top, .bottom], 3)
                            .background(Color("grayBgColor"))
                    }
                    
                    Text("\(self.comment.hotelUserCommentInfo.commentDateTime) \(self.comment.hotelUserCommentInfo.roomTypeName)")
                            .foregroundColor(.secondary)
                            .font(.caption)
                }
                
                Spacer()
                
                Text("\(self.comment.hotelUserCommentInfo.userScore, specifier: "%.1f")分")
                    .font(.subheadline)
                    .foregroundColor(Color("themeColor"))
                    .padding([.leading, .trailing], 10)
                    .padding([.top, .bottom], 3)
                    .background(Color("themeColor").opacity(0.15))
                    .cornerRadius(3)
            }
            .padding([.leading, .trailing], 10)
    
            Text(self.comment.hotelUserCommentInfo.commentContent)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false , vertical: true)
                .lineLimit(3)
                .padding([.leading, .trailing, .top], 10)
                .padding(.bottom, 15)
            
        }
        .background(Color.white)
        .cornerRadius(12)
        .padding([.top, .leading, .trailing], 10)
    }
    
    private func getFirstC(_ name: String) -> String {
        let index = name.index(name.startIndex, offsetBy: 1)
        return String(name[..<index])
    }
    
    
    private func getWidth(_ position: Double) -> CGFloat {
        return CGFloat(position / 5.0 * Self.commentLenght)
    }
    
    private func getCommentProgress(_ title: String, score: Double) -> some View {
        return HStack(spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(Color("black2Color"))
            
            ZStack {
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color("bgColor"))
                    
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color("themeColor"))
                        .frame(width: self.getWidth(score))
                }
            }
            .frame(width: CGFloat(Self.commentLenght), height: 6)
            
            Text("\(score, specifier: "%.1f")")
                .font(.caption)
                .foregroundColor(Color("themeColor"))
        }
    }
}
