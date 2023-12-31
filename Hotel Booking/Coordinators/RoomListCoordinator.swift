//
//  RoomListCoordinator.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 30.08.2023.
//

import UIKit

protocol RoomListCoordinatorOutput: AnyObject {
    func didTapBackButton(coordinator: Coordinator)
}

final class RoomListCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    private weak var parent: Coordinator?
    private let hotelName: String
    
    init(navigationController: UINavigationController,
         parent: Coordinator,
         hotelName: String) {
        self.navigationController = navigationController
        self.parent = parent
        self.hotelName = hotelName
    }
    
    override func start() {
        let viewModel = RoomListViewModel(output: self)
        let vc = RoomListViewController(viewModel: viewModel, hotelName: hotelName)
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(vc, animated: true)
    }

    deinit {
        print(#function, NSStringFromClass(RoomListCoordinator.self))
    }
}

extension RoomListCoordinator: RoomListViewModelProtocol {
    
    func didTapChooseNumberButton() {
        guard let parent = parent else { return }

        let bookingInfoCoordinator = BookingInfoCoordinator(
            navigationController: navigationController,
            parent: parent
        )
        parent.add(coordinator: bookingInfoCoordinator)
        bookingInfoCoordinator.start()
    }
    
    func didTapBackButton() {
        parent?.remove(coordinator: self)
        navigationController.popViewController(animated: true)
    }
    
}
