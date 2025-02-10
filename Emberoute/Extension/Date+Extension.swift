//
//  Date+Extension.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 08.02.25.
//

import Foundation

extension Date {
    
    func startOfDayUTC() -> String {
        let calendar = Calendar(identifier: .gregorian)
        let startOfDay = calendar.startOfDay(for: self)

        var utcCalendar = Calendar(identifier: .gregorian)
        utcCalendar.timeZone = TimeZone(secondsFromGMT: 0)!

        let components = calendar.dateComponents([.year, .month, .day], from: startOfDay)
        guard let utcDate = utcCalendar.date(from: components) else {
            return ""
        }
        return utcDate.toISO8601StringUTC()
    }

    func endOfDayUTC() -> String {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day], from: self)

        components.hour = 23
        components.minute = 59
        components.second = 59
        components.nanosecond = 0 // Very important for precision

        // Create a UTC calendar
        var utcCalendar = Calendar(identifier: .gregorian)
        utcCalendar.timeZone = TimeZone(secondsFromGMT: 0)! // Force UTC

        guard let endOfDay = utcCalendar.date(from: components) else {
            return "" // Handle potential error
        }

        return endOfDay.toISO8601StringUTC()
    }

    func toISO8601StringUTC() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: self)
    }
}
