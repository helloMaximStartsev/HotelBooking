//
//  MainHotelView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 30.08.2023.
//

import UIKit
import SnapKit

final class MainHotelView: UIView {
    
    private var hotelImages: [UIImage]?
    private var imageIndex = 0
    
    // MARK: - UI
    
    private let carouselView = CarouselView()
    private let ratingView = RatingView()
    private let hotelNameLabel = UILabel.makeLabel(
        font: UIFont.boldSystemFont(ofSize: 22),
        textColor: .black
    )
    private let hotelAddressLabel = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 14),
        textColor: UIColor(hexString: ColorConstants.darkBlue)
    )
    private let minimalPriceLabel = UILabel.makeLabel(
        font: UIFont.boldSystemFont(ofSize: 27),
        textColor: .black
    )
    private let priceForItLabel = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    
    func setHotelInfo(_ hotelInfo: HotelModel) {
        ratingView.setRating(text: "\(hotelInfo.rating) \(hotelInfo.ratingName)")
        hotelNameLabel.text = hotelInfo.name
        hotelAddressLabel.text = hotelInfo.address
        minimalPriceLabel.text = "от \(hotelInfo.minimalPrice.convertPrice())"
        priceForItLabel.text = hotelInfo.priceForIt
    }
    
    func setHotelImages(_ images: [UIImage]) {
        self.carouselView.configureView(data: images)
    }
    
}

// MARK: - Private functions

private extension MainHotelView {
    
    func setupView() {
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        backgroundColor = .white
    }
    
    func setupSubviews() {
        addSubview(carouselView)
        addSubview(ratingView)
        addSubview(hotelNameLabel)
        addSubview(hotelAddressLabel)
        addSubview(minimalPriceLabel)
        addSubview(priceForItLabel)
    }
    
    func setupLayout() {
        carouselView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(250)
        }
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(carouselView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        hotelNameLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        hotelAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(hotelNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        minimalPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(hotelAddressLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        priceForItLabel.snp.makeConstraints { make in
            make.leading.equalTo(minimalPriceLabel.snp.trailing).offset(8)
            make.bottom.equalTo(minimalPriceLabel.snp.bottom)
        }
    }
    
}
    
