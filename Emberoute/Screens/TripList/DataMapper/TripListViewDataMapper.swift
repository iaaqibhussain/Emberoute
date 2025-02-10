//
//  TripListViewDataMapper.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 08.02.25.
//

import Foundation
import MapKit

protocol TripListViewDataMapper {
    func map(_ trips: [Trip]) -> [TripListViewData]
}

final class TripListViewDataMapperImpl: TripListViewDataMapper {
    func map(_ trips: [Trip]) -> [TripListViewData] {
        let currentDate = Date()
        let localTimeZone = TimeZone.current
        let now = currentDate.addingTimeInterval(TimeInterval(localTimeZone.secondsFromGMT(for: currentDate)))
        let viewData = trips.flatMap { trip in
            trip.legs
                .filter { leg in
                    if let departureDate = DateFormatHelper.dateFromString(leg.departure.scheduled) {
                        return departureDate >= now
                    }
                    return false
                }
                .map { leg in
                    TripListViewData(
                        departureName: leg.origin.detailedName,
                        departureTime: "Departure: \(DateFormatHelper.dateFromString(leg.departure.scheduled))",
                        arrivalName: leg.destination.detailedName,
                        arrivalTime: "Arrival: \(DateFormatHelper.dateFromString(leg.arrival.scheduled))",
                        detail: TripDetailViewData(
                            description: makeDescription(with: trip, from: leg),
                            adultPrice: "£\(trip.prices.adult)",
                            childPrice: "£\(trip.prices.child)",
                            hasWifi: leg.description.amenities.hasWifi,
                            hasToilet: leg.description.amenities.hasToilet,
                            hasWheelchair: trip.availability.wheelchair > 0,
                            hasBicycle: trip.availability.bicycle > 0,
                            zone: leg.origin.zone.map {
                                CLLocationCoordinate2D(
                                    latitude: $0.latitude,
                                    longitude: $0.longitude
                                )
                            },
                            tripUID: leg.tripUid
                        )
                    )
                }
        }
        return viewData
    }
}

private extension TripListViewDataMapperImpl {
    func makeDescription(
        with trip: Trip,
        from leg: Legs
    ) -> NSMutableAttributedString {
        // Create the prices
        
        let prices = trip.prices
        let adult = "£\(prices.adult) / Adult"
        let child = "£\(prices.child) / Child"
        
        // Create the Vehicle info
        
        let vehicleInfo = "The vehicle is operated by \(leg.description.descriptionOperator) and carries the number plate \(leg.description.numberPlate)."

        // Create Available Seats info
        
        let availability = trip.availability
        let totalSeats = availability.seat > 0 ? "This bus has a total of \(availability.seat) seats." : "There are no more seats available."
        
        // Create Trip ID
        
        let tripUid = "Trip ID: \(leg.tripUid)"
        
        // Create Description Info
        
        let description = """
        This bus is scheduled to depart from \(leg.origin.detailedName) at \(DateFormatHelper.timeFromString(leg.departure.scheduled)) and is scheduled to arrive at \(leg.destination.detailedName) on \(DateFormatHelper.timeFromString(leg.arrival.scheduled)).
        \(totalSeats)
        \(vehicleInfo)
        \(tripUid)\n
        Fare: \t \(adult)
                    \t \(child)
        """
        
        
        let attributedString = NSMutableAttributedString(string: description)
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Futura-Bold", size: 14.0) as Any
        ]

        // Bold the important information
        
        let wordsToBold = [
            leg.origin.detailedName,
            leg.destination.detailedName,
            DateFormatHelper.timeFromString(leg.departure.scheduled),
            DateFormatHelper.timeFromString(leg.arrival.scheduled),
            "\(availability.seat)",
            "£\(prices.adult)",
            "£\(prices.child)",
            leg.description.descriptionOperator,
            leg.description.numberPlate,
            leg.tripUid
        ]
        
        for word in wordsToBold {
            let range = (description as NSString).range(of: word)
            if range.location != NSNotFound {
                attributedString.addAttributes(boldAttributes, range: range)
            }
        }
        
        return attributedString
    }
}
