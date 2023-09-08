//
//  DetailsTableViewCell.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 03.09.2023.
//

import UIKit
import SnapKit

final class DetailsTableViewCell: UITableViewCell {
    
    static let identifier = "DetailsTableViewCell"
    
    // MARK: - UI

    private let image: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private let detail = UILabel.makeLabel(
        font: UIFont.boldSystemFont(ofSize: 16),
        textColor: .black
    )
    private let detailDescription = UILabel.makeLabel(
        font: UIFont.boldSystemFont(ofSize: 14),
        textColor: UIColor(red: 130/255, green: 135/255, blue: 150/255, alpha: 1)
    )
    private let arrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "arrow-right"))
        return imageView
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

    func setCellData(_ cellData: DetailsCellModel) {
        image.image = cellData.image ?? UIImage()
        detail.text = cellData.label
        detailDescription.text = cellData.description
    }

}

// MARK: - Private functions

private extension DetailsTableViewCell {
    
    func setupCell() {
        selectionStyle = .none
    }
    
    func setupSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(detail)
        contentView.addSubview(detailDescription)
        contentView.addSubview(arrow)
    }
    
    func setupLayout() {
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        detail.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(image.snp.trailing).offset(12)
        }
        detailDescription.snp.makeConstraints { make in
            make.top.equalTo(detail.snp.bottom).offset(2)
            make.leading.equalTo(image.snp.trailing).offset(12)
            make.bottom.equalToSuperview().inset(10)
        }
        arrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
}

