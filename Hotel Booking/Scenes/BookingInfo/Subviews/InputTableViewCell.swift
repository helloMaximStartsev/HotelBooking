//
//  InputTableViewCellDelegate.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 01.09.2023.
//

import UIKit
import SnapKit

final class InputTableViewCell: UITableViewCell {
    
    static let identifier = "InputTableViewCell"
    
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: ColorConstants.lightGrey)
        view.layer.cornerRadius = 12
        return view
    }()
    private let label = UILabel.makeLabel(
        text: "label",
        font: UIFont.boldSystemFont(ofSize: 12),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private let textField = UILabel.makeLabel(
        text: "textField",
        font: UIFont.boldSystemFont(ofSize: 16),
        textColor: .black
    )
    
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupSubviews()
        setupLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions

    func setCellData(text: String) {
        label.text = text
        textField.text = text
    }

}

// MARK: - Private functions

private extension InputTableViewCell {
    
    func setupCell() {
        selectionStyle = .none
    }
    
    func setupSubviews() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(label)
        containerView.addSubview(textField)
    }
    
    func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(16)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
}
