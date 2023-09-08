//
//  TableViewAdjustedHeight.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 02.09.2023.
//

import UIKit

class TableViewAdjustedHeight: UITableView {
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
}
