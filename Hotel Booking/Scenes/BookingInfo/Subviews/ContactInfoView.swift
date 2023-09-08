//
//  ContactInfoView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 03.09.2023.
//

import UIKit
import SnapKit

final class ContactInfoView: UIView {
    
    // MARK: - UI
    
    private let customerInfoLabel = UILabel.makeLabel(
        text: StringConstants.customerInfoTitle,
        font: UIFont.systemFont(ofSize: 22),
        textColor: .black
    )
    private let phoneNumberCell = InputTableViewCell()
    private let emailCell = InputTableViewCell()
    private let securityDescriptionLabel = UILabel.makeLabel(
        text: StringConstants.securityDescriptionTitle,
        font: UIFont.systemFont(ofSize: 14),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    
    // MARK: - Override functions
    
    override func layoutSubviews() {
        setupView()
        setupSubviews()
        setupLayout()
        phoneNumberCell.setCellData(text: "Номер телефона")
        emailCell.setCellData(text: "Почта")
    }
    
}

// MARK: - Private functions

private extension ContactInfoView {
    
    func setupView() {
        layer.cornerRadius = 12
        backgroundColor = .white
    }
    
    func setupSubviews() {
        addSubview(customerInfoLabel)
        addSubview(phoneNumberCell)
        addSubview(emailCell)
        addSubview(securityDescriptionLabel)
    }
    
    func setupLayout() {
        customerInfoLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        phoneNumberCell.snp.makeConstraints { make in
            make.top.equalTo(customerInfoLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        emailCell.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberCell.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        securityDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(emailCell.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
}

private extension ContactInfoView {
    enum StringConstants {
        static let customerInfoTitle = "Информация о покупателе"
        static let securityDescriptionTitle = """
        Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту
        """
    }
}
