//
//  CarouselCell.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 03.09.2023.
//

import UIKit
import SnapKit

class CarouselCell: UICollectionViewCell {
    
    // MARK: - Subviews
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    // MARK: - Properties
    
    static let cellId = "CarouselCell"
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
}

// MARK: - Private methods

private extension CarouselCell {
    
    func setupUI() {
        backgroundColor = .clear
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - Public methods

extension CarouselCell {
    
    public func configure(image: UIImage?) {
        imageView.image = image
    }
    
}
