//
//  RoomListViewModel.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 30.08.2023.
//

import UIKit

protocol RoomListViewModelProtocol: AnyObject {
    func didTapChooseNumberButton()
    func didTapBackButton()
}

final class RoomListViewModel {
    
    private let networkService = NetworkService.shared
    private weak var output: RoomListViewModelProtocol?
    
    var rooms: Observable<[RoomModel]> = Observable(value: nil)
    
    // MARK: - Initialization
    
    init(output: RoomListViewModelProtocol) {
        self.output = output
        
        getRoomList()
    }
    
    func didTapChooseNumberButton() {
        output?.didTapChooseNumberButton()
    }
    
    func didTapBackButton() {
        output?.didTapBackButton()
    }
    
    func getRoomImages(urlStrings: [String], comletion: @escaping ([UIImage]) -> Void) {
        networkService.getImages(urlStrings: urlStrings) { images in
            DispatchQueue.main.async {
                comletion(images)
            }
        }
    }
    
    deinit {
        print(#function, NSStringFromClass(RoomListViewModel.self))
    }
    
}

// MARK: - Private functions

private extension RoomListViewModel {
    
    func getRoomList() {
        let urlString = "https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd"

        networkService.getRooms(urlString: urlString) { [unowned self] rooms in
            self.rooms.value = rooms.rooms
        }
    }
    
}
