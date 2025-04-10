//
//  APIEndpoint.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 4/9/25.
//

import Foundation

enum APIEndpoint {
    /// The Character endpoint and name search parameter
    case character(String)

    /// Return a URL request to perform the selected API call
    /// - Returns: a `URLRequest` to perform the API call with
    var request: URLRequest? {
        switch self {
        case .character(let name):
            var components = URLComponents()
            components.scheme = "https"
            components.host = "rickandmortyapi.com"
            components.path = "/api/character"
            components.queryItems = [
                URLQueryItem(name: "name", value: name),
            ]

            guard let url = components.url else {
                return nil
            }

            return URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        }
    }
}
