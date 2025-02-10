//
//  Request.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 08.02.25.
//


import Foundation

enum RequestType: String {
  case GET
  case POST
}

protocol Request {
    var path: String { get }
    var queryParams: [String : String] { get }
}

extension Request {
    var baseURL: String {
        "api.ember.to"
    }

    var version: String {
        "/v1"
    }

    var params: [String : Any] {
        [:]
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var queryParams: [String : String] {
        [:]
    }
    
    func createRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = "\(version)\(path)"
        
        if !queryParams.isEmpty {
            components.queryItems = queryParams.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components.url else { throw  NetworkError.invalidURL }
        #if DEBUG
        print("REQUEST: -------------- \n")
        print("URL: \(url)")
        print("QUERY PARAMETERS: \(queryParams)")
        print("BODY PARAMETERS: \(params)")
        print("REQUEST TYPE: \(requestType)")
        #endif
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if !params.isEmpty {
          urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }

        return urlRequest
    }
}
