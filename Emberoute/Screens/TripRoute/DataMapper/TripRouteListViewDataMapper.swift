//
//  TripRouteListViewDataMapper.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import UIKit
import MapKit

protocol TripRouteListViewDataMapper {
    func map(_ response: TripRouteResponseBody) -> TripRouteViewData
}

final class TripRouteListViewDataMapperImpl: TripRouteListViewDataMapper {

    func map(_ response: TripRouteResponseBody) -> TripRouteViewData {
        let route = response.route
        let gps = response.vehicle.gps
        let details = route.map {
            let location = $0.location
            return TripRouteDetailViewData(
                departureName: location.detailedName,
                departureTime: "Departure: \(DateFormatHelper.dateFromString($0.departure.scheduled))",
                arrivalTime: "Arrival: \(DateFormatHelper.dateFromString($0.arrival.scheduled))",
                zone: $0.location.zone.compactMap { zone in
                    CLLocationCoordinate2D(
                        latitude: zone.latitude,
                        longitude: zone.longitude
                )
                }
            )
        }
        return TripRouteViewData(
            vehicleGPS: CLLocationCoordinate2D(
                latitude: gps.latitude,
                longitude: gps.longitude
            ),
            details: details
        )
    }
}
