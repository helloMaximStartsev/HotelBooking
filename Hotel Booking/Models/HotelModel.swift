//
//  HotelModel.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 30.08.2023.
//

import Foundation

struct HotelModel: Decodable {
    let name: String
    let address: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let aboutTheHotel: AboutHotelModel
    
    enum CodingKeys: String, CodingKey {
        case name
        case address = "adress"
        case minimalPrice = "minimal_price"
        case priceForIt = "price_for_it"
        case rating
        case ratingName = "rating_name"
        case imageUrls = "image_urls"
        case aboutTheHotel = "about_the_hotel"
    }
}

struct AboutHotelModel: Decodable {
    let description: String
    let peculiarities: [String]
}
