//
//  AppCoordinator.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 01.09.2023.
//

import UIKit

class AppCoordinator: BaseCoordinator {
        
    private let window: UIWindow
    var navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    override func start() {
        let hotelInfoCoordinator = HotelInfoCoordinator(
            navigationController: navigationController,
            parent: self
        )
        add(coordinator: hotelInfoCoordinator)
        hotelInfoCoordinator.start()
    }

}
