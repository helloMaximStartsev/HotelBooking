//
//  RoomTableViewCell.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit
import SnapKit
import TTGTags

protocol RoomTableViewCellDelegate: AnyObject {
    func didTapChooseNumberButton()
}

final class RoomTableViewCell: UITableViewCell {
    
    static let identifier = "RoomTableViewCell"
    weak var delegate: RoomTableViewCellDelegate?
    
    // MARK: - UI
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    private let carouselView = CarouselView()
    private let roomNameLabel = UILabel.makeLabel(
        font: UIFont.boldSystemFont(ofSize: 22),
        textColor: .black
    )
    private lazy var tagView: TTGTextTagCollectionView = {
        let tagView = TTGTextTagCollectionView()
        tagView.alignment = .left
        tagView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return tagView
    }()
    private lazy var tagStyle: TTGTextTagStyle = {
        let style = TTGTextTagStyle()
        style.backgroundColor = UIColor(hexString: ColorConstants.lightGrey)
        style.borderColor = .clear
        style.cornerRadius = 5
        style.shadowColor = .clear
        style.extraSpace = CGSize(width: 20, height: 10)
        return style
    }()
    private let roomDetailsView = RoomDetailsView()
    private let priceLabel = UILabel.makeLabel(
        font: UIFont.boldSystemFont(ofSize: 27),
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
        roomNameLabel.text = room.name
        priceLabel.text = room.price.convertPrice()
        pricePerLabel.text = room.pricePer
        setPeculiarities(room.peculiarities)
    }
    
    func setRoomImages(_ images: [UIImage]) {
        carouselView.configureView(data: images)
    }
}

// MARK: - Private functions

private extension RoomTableViewCell {
    
    func setupCell() {
        backgroundColor = UIColor(hexString: ColorConstants.lightGrey)
        layer.cornerRadius = 12
        selectionStyle = .none
    }
    
    func setupSubviews() {
        contentView.addSubview(cellView)
        
        cellView.addSubview(carouselView)
        cellView.addSubview(roomNameLabel)
        cellView.addSubview(tagView)
        cellView.addSubview(roomDetailsView)
        cellView.addSubview(priceLabel)
        cellView.addSubview(pricePerLabel)
        cellView.addSubview(chooseNumberButton)
    }
    
    func setupLayout() {
        cellView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(4)
        }
        carouselView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(250)
        }
        roomNameLabel.snp.makeConstraints { make in
            make.top.equalTo(carouselView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        tagView.snp.makeConstraints { make in
            make.top.equalTo(roomNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        roomDetailsView.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(roomDetailsView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        pricePerLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
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
    
    func setPeculiarities(_ peculiarities: [String]) {
        peculiarities.forEach { peculiarity in
            let textTag = TTGTextTag(
                content: TTGTextTagStringContent(
                    text: peculiarity,
                    textFont: UIFont.systemFont(ofSize: 16),
                    textColor: UIColor(hexString: ColorConstants.darkGrey)),
                style: tagStyle
            )
            tagView.addTag(textTag)
            tagView.reload()
        }
    }
    
}
