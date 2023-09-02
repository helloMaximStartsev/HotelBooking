//
//  HotelDescriptionView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit
import SnapKit

final class HotelDescriptionView: UIView {
    
    // MARK: - UI
    
    private let aboutHotelLabel = UILabel.makeLabel(
        text: "Об отеле",
        font: UIFont.boldSystemFont(ofSize: 22),
        textColor: .black
    )
    private let hotelDescriptionLabel = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black,
        numberOfLines: 0
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
    
    func setHotelDescription(_ aboutHotelModel: AboutHotelModel) {
        hotelDescriptionLabel.text = "\(aboutHotelModel.description)"
    }
    
}

// MARK: - Private functions

private extension HotelDescriptionView {
    
    func setupView() {
        layer.cornerRadius = 12
        backgroundColor = .white
    }
    
    func setupSubviews() {
        addSubview(aboutHotelLabel)
        addSubview(hotelDescriptionLabel)
    }
    
    func setupLayout() {
        aboutHotelLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        hotelDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(aboutHotelLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    
}

