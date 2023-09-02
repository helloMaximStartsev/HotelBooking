//
//  RoomModel.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import Foundation

struct RoomsModel: Decodable {
    let rooms: [RoomModel]
}

struct RoomModel: Decodable {
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: [String]
    let imageUrls: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case pricePer = "price_per"
        case peculiarities
        case imageUrls = "image_urls"
    }
}

