//
//  Observable.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 30.08.2023.
//

final class Observable<T> {
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T?) -> Void)?
    
    init(value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T?) -> Void) {
        self.listener = listener
    }
}
