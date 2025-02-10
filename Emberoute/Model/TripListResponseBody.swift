//
//  TripListResponseBody.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import Foundation

// MARK: - TripListResponseBody
struct TripListResponseBody: Decodable {
    let quotes: [Trip]
    let minCardTransaction: Int
}

// MARK: - Trip
struct Trip: Decodable {
  let availability: Availability
  let prices: Prices
  let legs: [Legs]
  let bookable: Bool
}

// MARK: - Availability
struct Availability: Decodable {
  let seat: Int
  let wheelchair: Int
  let bicycle: Int
}

// MARK: - Prices
struct Prices: Decodable {
    let adult: Int
    let child: Int
    let youngChild: Int
    let concession: Int
    let seat: Int
    let wheelchair: Int
    let bicycle: Int
}

// MARK: - Legs
struct Legs: Decodable {
    let type: String
    let tripUid: String
    let addsCapacityForTripUid: String?
    let origin: Origin
    let destination: Destination
    let departure: Departure
    let arrival: Arrival
    let description: Description
    let tripType: String
}

// MARK: - Origin
struct Origin: Decodable {
    let id: Int
    let atcoCode: String?
    let detailedName: String
    let lat: Double
    let lon: Double
    let name: String
    let regionName: String
    let type: String
    let code: String
    let codeDetail: String
    let timezone: String
    let heading: Int
    let zone: [Zone]
    let hasFutureActivity: Bool
    let areaId: Int
    let locationTimeId: Int
    let bookingCutOffMins: Int
    let preBookedOnly: Bool
    let skipped: Bool
    let bookable: String
}

// MARK: - Destination
struct Destination: Decodable {
    let id: Int
    let atcoCode: String
    let detailedName: String
    let googlePlaceId: String
    let lat: Double
    let lon: Double
    let name: String
    let regionName: String
    let type: String
    let code: String
    let codeDetail: String
    let timezone: String
    let heading: Int
    let zone: [Zone]
    let hasFutureActivity: Bool
    let areaId: Int
    let locationTimeId: Int
    let bookingCutOffMins: Int
    let preBookedOnly: Bool
    let skipped: Bool
    let bookable: String
}

// MARK: - Departure
struct Departure: Decodable {
    let scheduled: String
    let actual: String?
    let estimated: String?
}

// MARK: - Arrival
struct Arrival: Decodable {
    let scheduled: String
    let actual: String?
    let estimated: String?
}

// MARK: - Description
struct Description: Decodable {
    let brand: String
    let descriptionOperator: String
    let destinationBoard: String
    let numberPlate: String
    let vehicleType: String
    let colour: String?
    let amenities: Amenities
    let isElectric : Bool

    enum CodingKeys: String, CodingKey {
        case brand
        case descriptionOperator = "operator"
        case destinationBoard
        case numberPlate
        case vehicleType
        case colour
        case amenities
        case isElectric
    }
}

// MARK: - Zone
struct Zone: Decodable {
    let longitude: Double
    let latitude: Double
}

// MARK: - Amenities
struct Amenities: Decodable {
    let hasWifi: Bool
    let hasToilet: Bool
}
