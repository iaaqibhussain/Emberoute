//
//  TripListViewDataMapperMock.swift
//  EmberouteTests
//
//  Created by Syed Muhammad Aaqib Hussain on 10.02.25.
//

import Foundation
@testable import Emberoute

final class TripListViewDataMapperMock: TripListViewDataMapper {
    var mapTripsReturnValue: [TripListViewData] = []

    func map(_ trips: [Trip]) -> [TripListViewData] {
        return mapTripsReturnValue
    }
}
