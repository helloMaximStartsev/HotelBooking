//
//  BookingInfoCoordinator.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit

protocol BookingInfoCoordinatorOutput: AnyObject {
    func didTapBackButton(coordinator: Coordinator)
}

final class BookingInfoCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    private weak var parent: Coordinator?
    
    init(navigationController: UINavigationController,
         parent: Coordinator) {
        self.navigationController = navigationController
        self.parent = parent
    }
    
    override func start() {
        let viewModel = BookingInfoViewModel(output: self)
        let vc = BookingInfoViewController(viewModel: viewModel)
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(vc, animated: true)
    }
    
    deinit {
        print(#function, NSStringFromClass(BookingInfoCoordinator.self))
    }
    
}

extension BookingInfoCoordinator: BookingInfoViewModelProtocol {
    
    func didTapPayButton() {
        guard let parent = parent else { return }

        let successScreenCoordinator = SuccessScreenCoordinator(
            navigationController: navigationController,
            parent: parent
        )
        parent.add(coordinator: successScreenCoordinator)
        successScreenCoordinator.start()
    }
    
    func didTapBackButton() {
        parent?.remove(coordinator: self)
        navigationController.popViewController(animated: true)
    }
    
}
