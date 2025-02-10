//
//  TripRouteViewData.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import UIKit
import MapKit

struct TripRouteViewData {
    let vehicleGPS: CLLocationCoordinate2D
    let details: [TripRouteDetailViewData]
}

struct TripRouteDetailViewData {
    let departureName: String
    let departureTime: String
    let arrivalTime: String
    let zone: [CLLocationCoordinate2D]
}
