//
//  HotelInfoCoordinator.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 30.08.2023.
//

import UIKit

protocol HotelInfoCoordinatorOutput: AnyObject {
    func didTapBackButton()
}

final class HotelInfoCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    private weak var parent: Coordinator?

    init(navigationController: UINavigationController,
         parent: Coordinator) {
        self.navigationController = navigationController
        self.parent = parent
    }
    
    override func start() {
        let viewModel = HotelInfoViewModel(moduleOutput: self)
        let vc = HotelInfoViewController(viewModel: viewModel)
        navigationController.isNavigationBarHidden = false
        navigationController.setViewControllers([vc], animated: false)
    }
    
    deinit {
        print(#function, NSStringFromClass(HotelInfoCoordinator.self))
    }

}

// MARK: - HotelInfoViewModelOutput

extension HotelInfoCoordinator: HotelInfoViewModelOutput {
    
    func didTapChooseNumbersButton() {
        guard let parent = parent else { return }
        
        let roomListCoordinator = RoomListCoordinator(
            navigationController: navigationController,
            parent: parent
        )
        parent.add(coordinator: roomListCoordinator)
        roomListCoordinator.start()
    }
    
}
