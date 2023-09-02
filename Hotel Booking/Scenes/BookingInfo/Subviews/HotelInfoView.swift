//
//  HotelInfoView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit
import SnapKit

final class HotelInfoView: UIView {
    
    // MARK: - UI
    
    private let ratingView = RatingView()
    private let hotelNameLabel = UILabel.makeLabel(
        font: UIFont.boldSystemFont(ofSize: 22),
        textColor: .black
    )
    private let hotelAddressLabel = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 14),
        textColor: UIColor(hexString: ColorConstants.darkBlue)
    )
    
    // MARK: - Public functions
    
    func setHotelInfo(_ bookingInfo: BookingModel) {
        ratingView.setRating(text: "\(bookingInfo.hotelRating) \(bookingInfo.ratingName)")
        hotelNameLabel.text = bookingInfo.hotelName
        hotelAddressLabel.text = bookingInfo.hotelAddress
    }
    
    override func layoutSubviews() {
        setupView()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Private functions

private extension HotelInfoView {
    
    func setupView() {
        layer.cornerRadius = 12
        backgroundColor = .white
    }
    
    func setupSubviews() {
        addSubview(ratingView)
        addSubview(hotelNameLabel)
        addSubview(hotelAddressLabel)
    }
    
    func setupLayout() {
        ratingView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        hotelNameLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        hotelAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(hotelNameLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
}
