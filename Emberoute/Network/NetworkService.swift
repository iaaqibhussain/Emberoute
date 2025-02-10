//
//  NetworkService.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 08.02.25.
//

import Foundation

protocol NetworkService {
    func execute<T: Decodable>(
        request: Request,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

final class NetworkServiceImpl: NetworkService {
    private let urlSession: URLSession
    private let parser: DataParser

    init(
        urlSession: URLSession = URLSession.shared,
        parser: DataParser = DataParserImpl()
    ) {
        self.urlSession = urlSession
        self.parser = parser
    }

    func execute<T: Decodable>(
        request: Request,
        completion: @escaping (_ response: Result<T, Error>) -> ()
    ) {
        do {
            let urlRequest = try request.createRequest()
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data {
                    do {
                        let model: T = try self.parser.parse(data: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let err = error {
                    completion(.failure(err))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}
