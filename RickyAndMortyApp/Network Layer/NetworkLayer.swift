//
//  NetworkLayer.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 4/9/25.
//

import Foundation

typealias DecodableSendable = Decodable & Sendable

protocol NetworkLayer: Sendable {
    /// Attempt to request data from given endpoint and decode JSON response as given type T
    /// - Parameters:
    ///   - request: The endpoint `URLRequest` object
    ///   - type: The object type to decode as
    /// - Returns: The decoded object if successful. Errors will be thrown if network request or decode fail.
    func fetchJsonData<T: DecodableSendable>(request: URLRequest, type: T.Type) async throws -> T
}
