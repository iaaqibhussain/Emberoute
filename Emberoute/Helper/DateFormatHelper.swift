//
//  DateFormatHelper.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import UIKit

final class DateFormatHelper {
    private init() {}
    
    private static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime, .withTimeZone]
        formatter.timeZone = .current
        return formatter
    }()
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        formatter.timeZone = .current
        return formatter
    }()
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = .current
        return formatter
    }()
    
    
    // MARK: - Public Methods
    
    static func startOfTodayISO() -> String {
        let now = Date()
        return now.startOfDayUTC()
    }
    
    static func endOfTodayISO() -> String {
        let now = Date()
        return now.endOfDayUTC()
    }
    
    static func dateFromString(_ dateString: String) -> Date? {
        if let date = isoFormatter.date(from: dateString) {
            return date
        }
        return nil
    }
    
    static func dateFromString(_ dateString: String) -> String {
        if let date = isoFormatter.date(from: dateString) {
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    static func timeFromString(_ dateString: String) -> String {
        if let date = isoFormatter.date(from: dateString) {
            return timeFormatter.string(from: date)
        }
        return ""
    }
}
