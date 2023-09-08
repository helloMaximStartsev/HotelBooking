//
//  RoomDetailsView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 02.09.2023.
//

import UIKit

final class RoomDetailsView: UIView {
    
    // MARK: - UI
    
    private let roomDetailsLabel = UILabel.makeLabel(
        text: "Подробнее о номере",
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkBlue)
    )
    private let rightArrow: UIImageView = {
        let rightArrow = UIImageView(image: UIImage(named: "chevron-right")?.withRenderingMode(.alwaysOriginal))
        return rightArrow
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private functions

private extension RoomDetailsView {
    
    private func setupView() {
        layer.cornerRadius = 5
        backgroundColor = UIColor(red: 13/255, green: 114/255, blue: 255/255, alpha: 0.1)
    }
    
    private func setupSubviews() {
        addSubview(roomDetailsLabel)
        addSubview(rightArrow)
        
        roomDetailsLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(10)
        }
        rightArrow.snp.makeConstraints { make in
            make.centerY.equalTo(roomDetailsLabel).offset(4)
            make.leading.equalTo(roomDetailsLabel.snp.trailing).offset(2)
            make.trailing.equalToSuperview().inset(5)
        }
        
    }
    
}

