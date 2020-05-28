//
//  ContentView.swift
//  ElongHotel
//
//  Created by MC on 2020/4/22.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State private var response: HotelDetailResponse?
    @State private var nearHotel: HotelDetailNear?
    
    @State private var showFilterDetail = false
    
    var body: some View {
        GeometryReader { geo in
             VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        ScrollView(.vertical) {
                            VStack {
                                self.getMainView()
        
                                if self.nearHotel != nil {
                                    HotelDetailNearView(near: self.nearHotel!)
                                }
        
                            }
                            .frame(maxWidth: .infinity)
                        }
        
                        if self.response != nil {
                            GeometryReader { geo in
                                 HotelDetailFilterDetailView(filters: self.response!.filterInfo.normalGoodsFilters, show: self.$showFilterDetail)
                                     .frame(width: geo.size.width, height: geo.size.height)
                                     .opacity(self.showFilterDetail ? 1 : 0)
                             }
                        }
                    }

                    }
                    .background(RadialGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple]), center: .center, startRadius: 50, endRadius: 600))
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        let resp: HotelDetailResponse = Bundle.main.decode("detail.json")
                        self.response = resp

                        let near: HotelDetailNear = Bundle.main.decode("detail_near.json")
                        self.nearHotel = near
                    }
        }
       
    }
    
    private func getMainView() -> some View {
        return Group {
            if self.response != nil {
                   VStack(alignment: .leading, spacing: 0) {
                       HotelDetailImagesView(imageItems: self.response!.imgList)
                           .padding(.top, 40)

                       HotelDetailInfoView(response: self.response!)

                       HotelDetailAddressView(response: self.response!)

                       if self.response?.banner != nil {
                           ZStack(alignment: .trailing) {
                               WebImage(url: URL(string: self.response!.banner!.bgPicUrl))
                                   .resizable()
                                   .scaledToFit()
                                   .animation(.easeInOut(duration: 0.5))
                                   .cornerRadius(12)
                                   .padding([.leading, .trailing, .top], 10)

                               Button(action: {

                               }) {
                                   Image(systemName: "xmark.circle")
                               }
                               .offset(x: -20, y: 5)
                               .foregroundColor(.secondary)
                           }
                       }

                       HotelDetailDateView(response: self.response!)

                        HotelDetailFilterView(response: self.response!) {
                            withAnimation(.easeOut(duration: 0.3)) {
                                self.showFilterDetail.toggle()
                            }
                        }

                       HotelDetailHotProductView(response: self.response!)

                       if self.response!.roomTypes != nil {
                        ForEach(self.response!.roomTypes!) { room in
                               HotelDetailRoomView(room: room)
                           }
                       }
                       
                       HotelDetailPoliciesView(policies: self.response!.policies)

                       HotelDetailCommentView(comment: self.response!.userComment)
                       
                   }
               }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
