//
//  TripRouteListViewModel.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import Foundation
import Combine
import MapKit

enum TripRouteListViewState {
    case loading
    case setupGPSMap(CLLocationCoordinate2D)
    case finished
    case error(String)
}

protocol TripRouteListViewModel {
    var title: String { get }
    var numberOfRows: Int { get }
    var onStateChange: AnyPublisher<TripRouteListViewState, Never> { get }
    
    func onViewDidLoad()
    func itemFor(rowAt index: Int) -> TripRouteDetailViewData
}

final class TripRouteListViewModelImpl: TripRouteListViewModel {
    private let repository: TripRouteListRepository
    private let mapper: TripRouteListViewDataMapper
    private let tripUID: String
    private var routes: [TripRouteDetailViewData] = []
    private var currentState = PassthroughSubject<TripRouteListViewState, Never>()
    
    var tripViewData: TripRouteViewData?
    
    var title: String {
        "Trip Route(s)"
    }
    
    var onStateChange: AnyPublisher<TripRouteListViewState, Never> {
        currentState.eraseToAnyPublisher()
    }
    
    var numberOfRows: Int {
        routes.count
    }
    
    
    init(
        repository: TripRouteListRepository = TripRouteListRepositoryImpl(),
        mapper: TripRouteListViewDataMapper = TripRouteListViewDataMapperImpl(),
        tripUID: String
    ) {
        self.repository = repository
        self.mapper = mapper
        self.tripUID = tripUID
    }
    
    func onViewDidLoad() {
        currentState.send(.loading)
        repository.fetchTripRoute(
            tripUID) { [weak self] (response: Result<TripRouteResponseBody, Error>) in
                guard let self else { return }
                switch response {
                case let .success(data):
                    let viewData = mapper.map(data)
                    routes = viewData.details
                    currentState.send(.setupGPSMap(viewData.vehicleGPS))
                    currentState.send(.finished)
                case let .failure(error):
                    print(error)
                    currentState.send(.error(error.localizedDescription))
                }
            }
    }
    
    func itemFor(rowAt index: Int) -> TripRouteDetailViewData {
        routes[index]
    }
}
