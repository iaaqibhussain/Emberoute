//
//  TripListViewModel.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 08.02.25.
//

import Combine

enum TripListViewState {
    case loading
    case finished
    case snackBar(String, Bool)
}

protocol TripListViewModel {
    var title: String { get }
    var numberOfRows: Int { get }
    var onStateChange: AnyPublisher<TripListViewState, Never> { get }
    
    func onViewDidLoad()
    func itemFor(rowAt index: Int) -> TripListViewData
}

final class TripListViewModelImpl: TripListViewModel {
    private let repository: TripListRepository
    private let mapper: TripListViewDataMapper
    private var quotes: [Trip] = []
    private var trips: [TripListViewData] = []
    private var currentState = PassthroughSubject<TripListViewState, Never>()
    
    var title: String {
        "Available Trips"
    }
    
    var onStateChange: AnyPublisher<TripListViewState, Never> {
        currentState.eraseToAnyPublisher()
    }

    var numberOfRows: Int {
        trips.count
    }
    
    init(
        repository: TripListRepository = TripListRepositoryImpl(),
        mapper: TripListViewDataMapper = TripListViewDataMapperImpl()
    ) {
        self.repository = repository
        self.mapper = mapper
    }
    
    func onViewDidLoad() {
        currentState.send(.loading)
        repository.fetchTrips { [weak self] response in
            guard let self else { return }
            switch response {
            case let .success(data):
                self.quotes = data.quotes
                self.trips = mapper.map(quotes)
                currentState.send(.finished)
                if trips.isEmpty {
                    currentState.send(.snackBar("No trips to show", true))
                }
            case let .failure(error):
                currentState.send(.snackBar(error.localizedDescription, false))
            }
        }
    }
    
    func itemFor(rowAt index: Int) -> TripListViewData {
        trips[index]
    }
}
