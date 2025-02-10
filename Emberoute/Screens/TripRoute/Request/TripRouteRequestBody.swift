//
//  TripRouteRequest.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import UIKit

struct TripRouteRequestBody: Request {
    let tripUID: String
    init(tripUID: String) {
        self.tripUID = tripUID
    }
    var path: String {
        "/trips/\(tripUID)"
    }
}
