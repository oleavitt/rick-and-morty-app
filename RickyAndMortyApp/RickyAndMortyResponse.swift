//
//  RickyAndMortyResponse.swift
//  RickyAndMortyApp
//
//  Created by Oren Leavitt on 4/9/25.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let rickyAndMortyResponse = try? JSONDecoder().decode(RickyAndMortyResponse.self, from: jsonData)

import Foundation

// MARK: - RickyAndMortyResponse
struct RickyAndMortyResponse: Codable {
    let info: Info?
    let results: [Result]?
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: JSONNull?
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: TypeEnum?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

enum Gender: String, Codable {
    case male = "Male"
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

enum Species: String, Codable {
    case alien = "Alien"
    case cronenberg = "Cronenberg"
    case human = "Human"
    case humanoid = "Humanoid"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum TypeEnum: String, Codable {
    case empty = ""
    case fishPerson = "Fish-Person"
    case humanWithAntennae = "Human with antennae"
    case robot = "Robot"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
