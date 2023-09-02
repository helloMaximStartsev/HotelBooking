//
//  RatingView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit

final class RatingView: UIView {
    
    // MARK: - UI
    
    private let rating: UILabel = {
        let rating = UILabel()
        rating.textColor = UIColor(hexString: ColorConstants.darkOrange)
        return rating
    }()
    private let starImageView: UIImageView = {
        let starImageView = UIImageView(image: UIImage(named: "Star"))
        return starImageView
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setRating(text: "5 Превосходно")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    
    func setRating(text: String) {
        rating.text = text
    }
    
}

// MARK: - Private functions

private extension RatingView {
    
    private func setupView() {
        layer.cornerRadius = 5
        backgroundColor = UIColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 0.2)
    }
    
    private func setupSubviews() {
        addSubview(starImageView)
        addSubview(rating)
        
        starImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(10)
            make.width.height.equalTo(15)
        }
        rating.snp.makeConstraints { make in
            make.centerY.equalTo(starImageView)
            make.leading.equalTo(starImageView.snp.trailing).offset(2)
            make.trailing.equalToSuperview().inset(10)
        }
        
    }
    
}
