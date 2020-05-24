//
//  HotelDetailImageItem.swift
//  ElongHotel
//
//  Created by MC on 2020/4/22.
//  Copyright © 2020 MC. All rights reserved.
//

import Foundation

final class HotelDetailImageItem: Codable, Identifiable {
    let id: String = UUID().uuidString
    let ImageUrl: String
}
