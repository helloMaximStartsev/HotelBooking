//
//  UIViewController.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 01.09.2023.
//

import UIKit

extension UIViewController {
    
    /// Sugar for adding view controller as a child
    ///
    /// - Parameters:
    ///   - viewController: View controller to add.
    func embedChild(_ viewController: UITableViewController, into container: UIView? = nil) {
        addChild(viewController)
        
        if let container = container {
            container.addSubview(viewController.tableView)
        } else {
            view.addSubview(viewController.tableView)
        }
        
        viewController.didMove(toParent: self)
    }
}
