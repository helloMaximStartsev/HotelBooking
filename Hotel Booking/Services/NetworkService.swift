//
//  NetworkService.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 30.08.2023.
//

import UIKit

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func getHotelInfo(urlString: String, completion: @escaping (HotelModel) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                guard let data = data else { return }
                
                do {
                    let hotel = try JSONDecoder().decode(HotelModel.self, from: data)
                    completion(hotel)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getRooms(urlString: String, completion: @escaping (RoomsModel) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                guard let data = data else { return }
                
                do {
                    let hotel = try JSONDecoder().decode(RoomsModel.self, from: data)
                    completion(hotel)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getBookingInfo(urlString: String, completion: @escaping (BookingModel) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                guard let data = data else { return }
                
                do {
                    let hotel = try JSONDecoder().decode(BookingModel.self, from: data)
                    completion(hotel)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let data = data,
                      let image = UIImage(data: data) else { return }
                
                completion(.success(image))
            }
        }.resume()
    }
    
    func getImages(urlStrings: [String], completion: @escaping ([UIImage]) -> Void) {
        var images: [UIImage] = []
        
        let dispatchGroup = DispatchGroup()
        for urlString in urlStrings {
            
            dispatchGroup.enter()
            
            getImage(urlString: urlString) { result in
                switch result {
                case .success(let image):
                    images.append(image)
                    
                case .failure(let error):
                    print(error)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(images)
        }
    }
    
}
    
