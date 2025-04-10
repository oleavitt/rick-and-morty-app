//
//  NetworkLayerLive.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 4/9/25.
//

import Foundation

actor NetworkLayerLive: NetworkLayer {
    /// Attempt to request data from given endpoint and decode JSON response as given type T
    /// - Parameters:
    ///   - request: The endpoint `URLRequest` object
    ///   - type: The object type to decode as
    /// - Returns: The decoded object if successful. Errors will be thrown if network request or decode fail.
    func fetchJsonData<T: DecodableSendable>(request: URLRequest, type: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) || httpResponse.statusCode == 404
        else {
            throw URLError(.badServerResponse)
        }

#if DEBUG
        // Dump the response JSON data to the Console, using JSONSerialization's pretty printed option.
        if let responseObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            if let jsonData = try? JSONSerialization.data(withJSONObject: responseObject, options: .prettyPrinted),
               let strData = String(data: jsonData, encoding: .utf8) {
                print("RESPONSE (JSON): \(strData)")
            } else {
                print("RESPONSE (OBJECT): ", responseObject)
            }
        } else  if let strData = String(data: data, encoding: .utf8) {
            print("RESPONSE (OTHER): \(strData)")
        } else {
            print("RESPONSE: None")
        }
#endif

        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
