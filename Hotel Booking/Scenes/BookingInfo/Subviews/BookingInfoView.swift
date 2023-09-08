//
//  BookingInfoView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 03.09.2023.
//

import UIKit
import SnapKit

final class BookingInfoView: UIView {
    
    // MARK: - UI
    
    private let leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        return stackView
    }()
    private let rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    private let departureTitle = UILabel.makeLabel(
        text: "Вылет из",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let countryCityTitle = UILabel.makeLabel(
        text: "Страна, город",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let datesTitle = UILabel.makeLabel(
        text: "Даты",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let numberOfNightsTitle = UILabel.makeLabel(
        text: "Кол-во ночей",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let hotelTitle = UILabel.makeLabel(
        text: "Отель",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let roomNameTitle = UILabel.makeLabel(
        text: "Номер",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let nutritionTitle = UILabel.makeLabel(
        text: "Питание",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let departure = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black
    )
    private let countryCity = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black
    )
    private let dates = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black
    )
    private let numberOfNights = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black
    )
    private let hotel = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black
    )
    private let roomName = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black
    )
    private let nutrition = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black
    )
    
    // MARK: - Public functions
    
    func setBookingInfo(_ bookingInfo: BookingModel) {
        departure.text = bookingInfo.departure
        countryCity.text = bookingInfo.arrivalCountry
        dates.text = "\(bookingInfo.tourDateStart) - \(bookingInfo.tourDateStop)"
        numberOfNights.text = "\(bookingInfo.numberOfNights)"
        hotel.text = bookingInfo.hotelName
        roomName.text = bookingInfo.room
        nutrition.text = bookingInfo.nutrition
    }
    
    override func layoutSubviews() {
        setupView()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Private functions

private extension BookingInfoView {
    
    func setupView() {
        layer.cornerRadius = 12
        backgroundColor = .white
    }
    
    func setupSubviews() {
        addSubview(leftStackView)
        addSubview(rightStackView)
        
        leftStackView.addArrangedSubview(departureTitle)
        leftStackView.addArrangedSubview(countryCityTitle)
        leftStackView.addArrangedSubview(datesTitle)
        leftStackView.addArrangedSubview(numberOfNightsTitle)
        leftStackView.addArrangedSubview(hotelTitle)
        leftStackView.addArrangedSubview(roomNameTitle)
        leftStackView.addArrangedSubview(nutritionTitle)
        
        rightStackView.addArrangedSubview(departure)
        rightStackView.addArrangedSubview(countryCity)
        rightStackView.addArrangedSubview(dates)
        rightStackView.addArrangedSubview(numberOfNights)
        rightStackView.addArrangedSubview(hotel)
        rightStackView.addArrangedSubview(roomName)
        rightStackView.addArrangedSubview(nutrition)
    }
    
    func setupLayout() {
        leftStackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
            make.top.equalTo(leftStackView.snp.top)
        }
        rightStackView.snp.makeConstraints { make in
            make.top.equalTo(leftStackView.snp.top)
            make.leading.equalTo(leftStackView.snp.trailing).offset(40)
            make.width.equalTo(210)
        }
        hotelTitle.snp.makeConstraints { make in
            make.height.equalTo(hotel.snp.height)
        }
        roomNameTitle.snp.makeConstraints { make in
            make.height.equalTo(roomName.snp.height)
        }
        nutritionTitle.snp.makeConstraints { make in
            make.height.equalTo(nutrition.snp.height)
        }
    }
    
}
