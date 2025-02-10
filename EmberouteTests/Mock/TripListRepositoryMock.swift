//
//  TripListRepositoryMock.swift
//  EmberouteTests
//
//  Created by Syed Muhammad Aaqib Hussain on 10.02.25.
//

import Foundation
@testable import Emberoute

final class TripListRepositoryMock: TripListRepository {
    var fetchTripsResult: Result<TripListResponseBody, Error>?

    func fetchTrips(_ completion: @escaping (Result<TripListResponseBody, Error>) -> Void) {
        if let result = fetchTripsResult {
            completion(result)
        }
    }
}

