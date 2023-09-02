//
//  CollapsibleHeaderView.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 01.09.2023.
//

import UIKit
import SnapKit

protocol CollapsibleTableViewHeaderDelegate: AnyObject {
    func toggleSection(header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    
    static let identifier = "CollapsibleTableViewHeader"
    weak var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int?
    
    private let header = UILabel.makeLabel(
        text: "header",
        font: UIFont.boldSystemFont(ofSize: 22),
        textColor: .black
    )
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
        contentView.addSubview(header)
    }
    
    func setupLayout() {
        header.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(15)
        }
    }
    
    @objc
    func didTapHeader(gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader,
              let section = cell.section else { return }
        
        delegate?.toggleSection(header: self, section: section)
    }
    
    func setup(header: String, section: Int, delegate: CollapsibleTableViewHeaderDelegate) {
            self.delegate = delegate
            self.section = section
            self.header.text = header
        }

}
