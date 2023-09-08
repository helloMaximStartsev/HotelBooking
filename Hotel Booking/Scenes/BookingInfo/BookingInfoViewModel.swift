//
//  BookingInfoViewModel.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit

protocol BookingInfoViewModelProtocol: AnyObject {
    func didTapPayButton()
    func didTapBackButton()
}

final class BookingInfoViewModel {
    
    private let networkService = NetworkService.shared
    private weak var output: BookingInfoViewModelProtocol?
    
    var isPhoneNumberValid = false
    var isEmailValid = false
    var isTuristFormValid = false

    var isFormValid: Observable<Bool> = Observable(value: nil)
    var bookingInfo: Observable<BookingModel> = Observable(value: nil)
    
    // MARK: - Initialization
    
    init(output: BookingInfoCoordinator) {
        self.output = output

        getBookingInfo()
    }
    
    func didTapPayButton() {
        output?.didTapPayButton()
    }
    
    func didTapBackButton() {
        output?.didTapBackButton()
    }
    
    deinit {
        print(#function, NSStringFromClass(BookingInfoViewModel.self))
    }
}

// MARK: - Private functions

private extension BookingInfoViewModel {
    
    func getBookingInfo() {
        let urlString = "https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8"

        networkService.getBookingInfo(urlString: urlString) { [unowned self] bookingInfo in
            self.bookingInfo.value = bookingInfo
        }
    }
    
}
