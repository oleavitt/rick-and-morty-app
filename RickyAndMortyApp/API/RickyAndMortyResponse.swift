//
//  RickyAndMortyResponse.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 4/9/25.
//

import Foundation

// Codable Swift data models generated using https://quicktype.io/
// and touched up for our use.

// MARK: - RickyAndMortyResponse
struct RickyAndMortyResponse: Codable {
    let info: RickyAndMortyInfo?
    let results: [RickyAndMortyResult]?
    let error: String?
}

// MARK: - RickyAndMortyInfo
struct RickyAndMortyInfo: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - RickyAndMortyResult
struct RickyAndMortyResult: Codable {
    let id: Int
    let name: String
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin, location: RickyAndMortyLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?

#if DEBUG
    // Static sample for previewing
    static let sample = RickyAndMortyResult(id: 139,
                                            name: "General Store Owner",
                                            status: "Dead",
                                            species: "Alien",
                                            type: "Cat-Person",
                                            gender: "Male",
                                            origin: RickyAndMortyLocation(name: "Purge Planet", url: "https://rickandmortyapi.com/api/location/9"),
                                            location: RickyAndMortyLocation(name: "Purge Planet", url: "https://rickandmortyapi.com/api/location/9"),
                                            image: "https://rickandmortyapi.com/api/character/avatar/139.jpeg", episode: ["https://rickandmortyapi.com/api/episode/20"],
                                            url: "https://rickandmortyapi.com/api/character/139",
                                            created: "2017-12-27T18:41:03.124Z")
#endif
}

extension RickyAndMortyResult: Hashable {
    static func == (lhs: RickyAndMortyResult, rhs: RickyAndMortyResult) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - RickyAndMortyLocation
struct RickyAndMortyLocation: Codable {
    let name: String?
    let url: String?
}

extension RickyAndMortyLocation: Hashable {
    static func == (lhs: RickyAndMortyLocation, rhs: RickyAndMortyLocation) -> Bool {
        lhs.name == rhs.name
    }
}
