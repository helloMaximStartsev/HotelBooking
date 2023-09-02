//
//  TileView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit

final class TileView: UIView {

    // MARK: - UI

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: ColorConstants.darkGrey)
        return label
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setLabel(text: "5 Превосходно")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    
    func setLabel(text: String) {
        label.text = text
    }
    
}

// MARK: - Private functions

private extension TileView {
    
    private func setupView() {
        layer.cornerRadius = 5
        backgroundColor = UIColor(hexString: ColorConstants.lightGrey)
    }
    
    private func setupSubviews() {
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(5)
        }
        
    }
    
}
