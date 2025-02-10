//
//  TripDetailViewModel.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import Foundation
import Combine

enum TripDetailViewState {
    case update(TripDetailViewData)
}

protocol TripDetailViewModel {
    var title: String { get }
    var tripUID: String { get }
    var onStateChange: AnyPublisher<TripDetailViewState, Never> { get }
    func onViewDidLoad()
}

final class TripDetailViewModelImpl: TripDetailViewModel {
    private let input: TripDetailViewData
    private var currentState = PassthroughSubject<TripDetailViewState, Never>()
    init(input: TripDetailViewData) {
        self.input = input
    }
    
    var tripUID: String {
        input.tripUID
    }
    
    var title: String {
        "Trip Details"
    }
    
    var onStateChange: AnyPublisher<TripDetailViewState, Never> {
        currentState.eraseToAnyPublisher()
    }

    func onViewDidLoad() {
        currentState.send(.update(input))
    }
}
