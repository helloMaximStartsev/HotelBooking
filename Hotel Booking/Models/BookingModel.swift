//
//  BookingModel.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import Foundation

struct BookingModel: Decodable {
    let hotelName: String
    let hotelAddress: String
    let hotelRating: Int
    let ratingName: String
    let departure: String
    let arrivalCountry: String
    let tourDateStart: String
    let tourDateStop: String
    let numberOfNights: Int
    let room: String
    let nutrition: String
    let tourPrice: Int
    let fuelCharge: Int
    let serviceCharge: Int
    
    enum CodingKeys: String, CodingKey {
        case hotelName = "hotel_name"
        case hotelAddress = "hotel_adress"
        case hotelRating = "horating"
        case ratingName = "rating_name"
        case departure
        case arrivalCountry = "arrival_country"
        case tourDateStart = "tour_date_start"
        case tourDateStop = "tour_date_stop"
        case numberOfNights = "number_of_nights"
        case room
        case nutrition
        case tourPrice = "tour_price"
        case fuelCharge = "fuel_charge"
        case serviceCharge = "service_charge"
    }
}
