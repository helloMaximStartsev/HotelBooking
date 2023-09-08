//
//  HotelInfoViewModel.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 30.08.2023.
//

import UIKit


protocol HotelInfoViewModelOutput: AnyObject {
    func didTapChooseNumbersButton(hotelName: String)
}

final class HotelInfoViewModel {
    
    private let networkService = NetworkService.shared
    private weak var moduleOutput: HotelInfoViewModelOutput?
    
    var hotelInfo: Observable<HotelModel> = Observable(value: nil)
    var hotelImages: Observable<[UIImage]> = Observable(value: nil)
    
    // MARK: - Initialization
    
    init(moduleOutput: HotelInfoViewModelOutput) {
        self.moduleOutput = moduleOutput

        getHotelInfo()
    }
    
    func didTapChooseNumbersButton(hotelName: String) {
        moduleOutput?.didTapChooseNumbersButton(hotelName: hotelName)
    }
    
    deinit {
        print(#function, NSStringFromClass(HotelInfoViewModel.self))
    }
    
}

// MARK: - Private functions

private extension HotelInfoViewModel {
    
    func getHotelInfo() {
        let urlString = "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"

        networkService.getHotelInfo(urlString: urlString) { [unowned self] hotelInfo in
            self.hotelInfo.value = hotelInfo
            self.getImages(urlStrings: hotelInfo.imageUrls)
        }
    }
    
    func getImages(urlStrings: [String]) {
        networkService.getImages(urlStrings: urlStrings) { [unowned self] images in
            self.hotelImages.value = images
        }
    }
    
}
