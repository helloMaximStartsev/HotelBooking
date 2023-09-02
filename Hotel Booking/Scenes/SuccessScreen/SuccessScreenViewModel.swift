//
//  SuccessScreenViewModel.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit

protocol SuccessScreenViewModelProtocol: AnyObject {
    func didTapSuperButton()
    func didTapBackButton()
}

final class SuccessScreenViewModel {
    
    private let networkService = NetworkService.shared
    private weak var output: SuccessScreenViewModelProtocol?
    
    var SuccessScreen: Observable<HotelModel> = Observable(value: nil)
    
    // MARK: - Initialization
    
    init(output: SuccessScreenViewModelProtocol) {
        self.output = output
    }
    
    func didTapSuperButton() {
        output?.didTapSuperButton()
    }
    
    func didTapBackButton() {
        output?.didTapBackButton()
    }
    
    deinit {
        print(#function, NSStringFromClass(SuccessScreenViewModel.self))
    }
}
