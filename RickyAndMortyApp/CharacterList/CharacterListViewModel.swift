//
//  CharacterListViewModel.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 4/9/25.
//

import Foundation

@MainActor
final class CharacterListViewModel: ObservableObject {
    @Published var state: CharacterListViewState = .empty
    @Published var name: String = ""

    private let networkLayer: NetworkLayer
    private var apiResponse: RickyAndMortyResponse?
    private var error: Error?
    private var errorMessageInternal = ""

    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }

    /// Get the underlying array of character results contained within the response object - if we have it
    var characters: [RickyAndMortyResult] {
        apiResponse?.results ?? []
    }

    /// Perforn network request to download list of characters queried by "name"
    func fetchCharacters() async {
        guard state != .loading else { return }

        guard let urlRequest = APIEndpoint.character(name).request else {
            error = URLError(.badURL)
            state = .error
            return
        }

        state = .loading

        do {
            apiResponse = try await networkLayer.fetchJsonData(request: urlRequest, type: RickyAndMortyResponse.self)
            state = isEmpty ? .empty : .success
        } catch let decodingError as DecodingError {
            errorMessageInternal = String(localized: "content-could-not-be-decoded")
            self.error = decodingError
            state = .error
        } catch {
            errorMessageInternal = String(localized: "unable-to-download-content")
            self.error = error
            state = .error
        }
    }

    var isEmpty: Bool {
        apiResponse?.results?.isEmpty ?? true
    }

    var errorMessage: String {
        if errorMessageInternal.isEmpty {
            return error?.localizedDescription ?? ""
        }
        return errorMessageInternal
    }
}
