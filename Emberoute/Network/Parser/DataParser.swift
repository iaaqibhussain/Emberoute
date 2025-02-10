//
//  DataParser.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 08.02.25.
//

import Foundation

protocol DataParser {
    func parse<T: Decodable>(data: Data) throws -> T
}

final class DataParserImpl: DataParser {
    private var jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func parse<T: Decodable>(data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
