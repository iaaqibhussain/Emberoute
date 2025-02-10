//
//  TripListRepository.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import Foundation

protocol TripListRepository {
    func fetchTrips(_ completion: @escaping((Result<TripListResponseBody, Error>) -> Void))
}

final class TripListRepositoryImpl: TripListRepository {
    private let networkService: NetworkService
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func fetchTrips(_ completion: @escaping ((Result<TripListResponseBody, Error>) -> Void)) {
        let request = TripListRequestBody()
        networkService.execute(
            request: request,
            completion: completion
        )
    }
}
