//
//  HotelDetailNear.swift
//  ElongHotel
//
//  Created by MC on 2020/5/4.
//  Copyright © 2020 MC. All rights reserved.
//

import Foundation

final class HotelDetailNear: Codable {
    let HotelList: [Hotel]
    let SurroundRecomHotelNum: Int
}

final class Hotel: Codable, Identifiable {
    let id = UUID().uuidString
    let Distance: Int
    let name: String
    let price: Int
    let PicUrl: String
    let commentScore: Double
}
