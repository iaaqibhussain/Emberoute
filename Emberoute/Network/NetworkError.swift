//
//  NetworkError.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 08.02.25.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case error(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL string is malformed."
        case let .error(error):
            return error.localizedDescription
        }
    }
}
