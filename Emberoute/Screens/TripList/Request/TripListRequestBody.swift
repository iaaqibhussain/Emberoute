//
//  TripListRequest.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 08.02.25.
//

import UIKit

struct TripListRequestBody: Request {
    let data: TripListRequestBodyData
    init(data: TripListRequestBodyData = TripListRequestBodyData()) {
        self.data = data
    }
    
    var path: String {
        "/quotes/"
    }
    
    var queryParams: [String : String] {
        [
            "origin": "13",
            "destination": "42",
            "departure_date_from": data.dateFrom,
            "departure_date_to": data.dateTo
        ]
    }
}
