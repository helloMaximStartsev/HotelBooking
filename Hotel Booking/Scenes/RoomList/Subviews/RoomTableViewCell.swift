//
//  RoomTableViewCell.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit
import SnapKit

protocol RoomTableViewCellDelegate: AnyObject {
    func didTapChooseNumberButton()
}

final class RoomTableViewCell: UITableViewCell {
    
    static let identifier = "RoomTableViewCell"
    weak var delegate: RoomTableViewCellDelegate?
    
    // MARK: - UI
    
    private let roomImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Hotel"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    private let roomNameLabel = UILabel.makeLabel(
        font: UIFont.boldSystemFont(ofSize: 22),
        textColor: .black
    )
    private let priceLabel = UILabel.makeLabel(
        font: UIFont.boldSystemFont(ofSize: 30),
        textColor: .black
    )
    private let pricePerLabel = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private lazy var chooseNumberButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: ColorConstants.darkBlue)
        button.layer.cornerRadius = 15
        button.setTitle("Выбрать номер", for: .normal)
        button.addTarget(self, action: #selector(didTapChooseNumberButton), for: .touchUpInside)
        return button
    }()
    
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

    func setCellData(room: RoomModel) {
        self.roomNameLabel.text = room.name
        self.priceLabel.text = room.price.convertPrice()
        self.pricePerLabel.text = room.pricePer
    }

}

// MARK: - Private functions

private extension RoomTableViewCell {
    
    func setupCell() {
        backgroundColor = .white
        layer.cornerRadius = 12
        selectionStyle = .none
    }
    
    func setupSubviews() {
        contentView.addSubview(roomImageView)
        contentView.addSubview(roomNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(pricePerLabel)
        contentView.addSubview(chooseNumberButton)
    }
    
    func setupLayout() {
        roomImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(250)
        }
        roomNameLabel.snp.makeConstraints { make in
            make.top.equalTo(roomImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(roomNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        pricePerLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel.snp.trailing).offset(8)
            make.bottom.equalTo(priceLabel.snp.bottom)
        }
        chooseNumberButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
    @objc
    func didTapChooseNumberButton() {
        delegate?.didTapChooseNumberButton()
    }
    
}
