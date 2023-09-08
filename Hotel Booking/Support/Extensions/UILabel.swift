//
//  UILabel.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit

extension UILabel {
    
    static func makeLabel(text: String? = nil, font: UIFont, textColor: UIColor, numberOfLines: Int? = nil, textAlignment: NSTextAlignment? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines ?? 2
        label.textAlignment = textAlignment ?? .left
        return label
    }
    
}
