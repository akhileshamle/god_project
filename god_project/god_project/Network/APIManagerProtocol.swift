//
//  APIManagerProtocol.swift
//  god_project
//
//  Created by Akhilesh Amle on 17/11/23.
//

import Foundation

protocol APIManagerProtocol {
    func perform(
        _ request: RequestProtocol,
        authToken: String
    ) async throws -> Data
}

class APIManager: APIManagerProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform(
        _ request: RequestProtocol,
        authToken: String = ""
    ) async throws -> Data {
        let (data, response) = try await urlSession.data(
            for: request.createURLRequest(authToken: authToken)
        )
        
        guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        return data
    }
}
