//
//  SuccessScreenCoordinator.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit

final class SuccessScreenCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    private weak var parent: Coordinator?
    
    init(navigationController: UINavigationController,
         parent: Coordinator) {
        self.navigationController = navigationController
        self.parent = parent
    }
    
    override func start() {
        let viewModel = SuccessScreenViewModel(output: self)
        let vc = SuccessScreenViewController(viewModel: viewModel)
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(vc, animated: true)
    }
    
    deinit {
        print(#function, NSStringFromClass(SuccessScreenCoordinator.self))
    }
    
}

extension SuccessScreenCoordinator: SuccessScreenViewModelProtocol {
    
    func didTapSuperButton() {
        parent?.removeAllButFirst()
        navigationController.popToRootViewController(animated: true)
    }
    
    func didTapBackButton() {
        parent?.remove(coordinator: self)
        navigationController.popViewController(animated: true)
    }
    
}
