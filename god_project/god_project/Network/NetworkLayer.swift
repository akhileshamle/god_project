//
//  NetworkLayer.swift
//  god_project
//
//  Created by Akhilesh Amle on 16/11/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
}

struct APIConstants {
    static let host = ""
}

enum RequestType: String {
    case GET
    case POST
}

protocol RequestProtocol {
    var path: String { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
    var addAuthorizationToken: Bool { get }
    var requestType: RequestType { get }
}

extension RequestProtocol {
    var host: String {
        APIConstants.host
    }
    
    var addAuthorizationToken: Bool {
        true
    }
    
    var params: [String: String] {
        [:]
    }
    
    var urlParams: [String: Any] {
        [:]
    }
    
    var headers: [String: String] {
        [:]
    }
    
    func createURLRequest(authToken: String) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if !urlParams.isEmpty {
            components.queryItems = urlParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        if addAuthorizationToken {
            urlRequest.setValue(
                authToken,
                forHTTPHeaderField: "Authorization"
            )
        }
        
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(
                withJSONObject: params
            )
        }
        
        return urlRequest
    }
}
