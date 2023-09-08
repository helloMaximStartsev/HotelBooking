//
//  PaymentInfoView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 04.09.2023.
//

import UIKit
import SnapKit

final class PaymentInfoView: UIView {
    
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
        stackView.alignment = .trailing
        return stackView
    }()
    private let tourPriceTitle = UILabel.makeLabel(
        text: "Тур",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let fuelChargeTitle = UILabel.makeLabel(
        text: "Топливный сбор",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let serviceChargeTitle = UILabel.makeLabel(
        text: "Сервисный сбор",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let totalPriceTitle = UILabel.makeLabel(
        text: "К оплате",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let tourPrice = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black
    )
    private let fuelCharge = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black
    )
    private let serviceCharge = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black
    )
    private let totalPrice = UILabel.makeLabel(
        font: UIFont.boldSystemFont(ofSize: 16),
        textColor: UIColor(red: 13/255, green: 114/255, blue: 255/255, alpha: 1)
    )
    
    // MARK: - Public functions
    
    func setPaymentInfo(_ bookingInfo: BookingModel) {
        tourPrice.text = bookingInfo.tourPrice.convertPrice()
        fuelCharge.text = bookingInfo.fuelCharge.convertPrice()
        serviceCharge.text = bookingInfo.serviceCharge.convertPrice()
        totalPrice.text = (bookingInfo.tourPrice + bookingInfo.fuelCharge + bookingInfo.serviceCharge).convertPrice()
    }
    
    override func layoutSubviews() {
        setupView()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Private functions

private extension PaymentInfoView {
    
    func setupView() {
        layer.cornerRadius = 12
        backgroundColor = .white
    }
    
    func setupSubviews() {
        addSubview(leftStackView)
        addSubview(rightStackView)
        
        leftStackView.addArrangedSubview(tourPriceTitle)
        leftStackView.addArrangedSubview(fuelChargeTitle)
        leftStackView.addArrangedSubview(serviceChargeTitle)
        leftStackView.addArrangedSubview(totalPriceTitle)
        
        rightStackView.addArrangedSubview(tourPrice)
        rightStackView.addArrangedSubview(fuelCharge)
        rightStackView.addArrangedSubview(serviceCharge)
        rightStackView.addArrangedSubview(totalPrice)
    }
    
    func setupLayout() {
        leftStackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
            make.top.equalTo(leftStackView.snp.top)
        }
        rightStackView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }
    }
    
}

