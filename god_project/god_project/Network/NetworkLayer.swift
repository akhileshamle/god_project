//
//  NetworkLayer.swift
//  god_project
//
//  Created by Akhilesh Amle on 16/11/23.
//

import Foundation

struct APIConstants {
    static let host = ""
}

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
}
