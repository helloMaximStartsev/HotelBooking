//
//  HotelDescriptionView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit
import SnapKit
import TTGTags

final class HotelDescriptionView: UIView {
    
    // MARK: - UI
    
    private let aboutHotelLabel = UILabel.makeLabel(
        text: "Об отеле",
        font: UIFont.boldSystemFont(ofSize: 22),
        textColor: .black
    )
    private lazy var tagView: TTGTextTagCollectionView = {
        let tagView = TTGTextTagCollectionView()
        tagView.alignment = .left
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
    private let hotelDescriptionLabel = UILabel.makeLabel(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .black,
        numberOfLines: 0
    )
    private lazy var tableView: TableViewAdjustedHeight = {
        let tableView = TableViewAdjustedHeight()
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = 15
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(red: 130/255, green: 135/255, blue: 150/255, alpha: 0.05)
        return tableView
    }()
    
    let detailsCellData = [
        DetailsCellModel(image: UIImage(named: "emoji-happy"), label: "Удобства", description: "Самое необходимое"),
        DetailsCellModel(image: UIImage(named: "tick-square"), label: "Что включено", description: "Самое необходимое"),
        DetailsCellModel(image: UIImage(named: "close-square"), label: "Что не включено", description: "Самое необходимое")
    ]
    
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
        setPeculiarities(aboutHotelModel.peculiarities)
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
        addSubview(tagView)
        addSubview(hotelDescriptionLabel)
        addSubview(tableView)
    }
    
    func setupLayout() {
        aboutHotelLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        tagView.snp.makeConstraints { make in
            make.top.equalTo(aboutHotelLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        hotelDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(hotelDescriptionLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
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

// MARK: - UITableViewDataSource

extension HotelDescriptionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailsCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as? DetailsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCellData(detailsCellData[indexPath.row])
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension HotelDescriptionView: UITableViewDelegate {
    
}
