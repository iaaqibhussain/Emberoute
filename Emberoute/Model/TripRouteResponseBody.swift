//
//  TripRouteResponseBody.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import Foundation

// MARK: - RouteResponse
struct TripRouteResponseBody: Decodable {
    let route: [Route]
    let vehicle: Vehicle
    let description: TripRouteDescription
}

// MARK: - Description
struct TripRouteDescription: Decodable {
    let routeNumber: String
    let patternId: Int
    let calendarDate: String
    let type: String
    let isCancelled: Bool
    let routeId: Int
}

// MARK: - Vehicle
struct Vehicle: Decodable {
    let bicycle: Int
    let wheelchair: Int
    let seat: Int
    let id: Int
    let plateNumber: String
    let name: String
    let hasWifi: Bool
    let hasToilet: Bool
    let type: String
    let brand: String
    let colour: String
    let isBackupVehicle: Bool
    let ownerId: Int
    let gps: GPS
}

// MARK: - GPS
struct GPS: Decodable {
    let lastUpdated: String
    let longitude: Double
    let latitude: Double
    let heading: Int?
}

// MARK: - Route
struct Route: Decodable {
    let id: Int
    let departure: Departure
    let arrival: Arrival
    let location: Location
    let allowBoarding: Bool
    let allowDropOff: Bool
    let bookingCutOffMins: Int
    let preBookedOnly: Bool
    let skipped: Bool
}

// MARK: - Location
struct Location: Decodable {
    let id: Int
    let type: String
    let name: String
    let regionName: String?
    let code: String
    let codeDetail: String
    let detailedName: String
    let direction: String?
    let lon: Double
    let lat: Double
    let googlePlaceId: String?
    let atcoCode: String
    let hasFutureActivity: Bool
    let timezone: String
    let zone: [Zone]
    let heading: Int?
    let areaId: Int
}
