//
//  TripDetailViewData.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import Foundation
import MapKit

struct TripDetailViewData {
    let description: NSMutableAttributedString
    let adultPrice: String
    let childPrice: String
    let hasWifi: Bool
    let hasToilet: Bool
    let hasWheelchair: Bool
    let hasBicycle: Bool
    let zone: [CLLocationCoordinate2D]
    let tripUID: String
}
