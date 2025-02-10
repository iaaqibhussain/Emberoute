//
//  TripRouteListRepository.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import Foundation

protocol TripRouteListRepository {
    func fetchTripRoute(
        _ tripUID: String,
        _ completion: @escaping((Result<TripRouteResponseBody, Error>) -> Void)
    )
}

final class TripRouteListRepositoryImpl: TripRouteListRepository {
    private let networkService: NetworkService
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func fetchTripRoute(
        _ tripUID: String,
        _ completion: @escaping((Result<TripRouteResponseBody, Error>) -> Void)
    ) {
        let request = TripRouteRequestBody(tripUID: tripUID)
        networkService.execute(
            request: request,
            completion: completion
        )
    }
}

