//
//  RandomUserAPIResponse.swift
//  JustoTechChallenge
//
//  Created by Natalia Goyes on 31/08/22.
//

import Foundation

struct RandomUserAPIResponse: Codable, Equatable {
    let users: [RandomUserInfo]
    let information: PaginationInfo
    
    private enum CodingKeys: String, CodingKey {
        case users = "results", information = "info"
    }
}

struct PaginationInfo: Codable, Equatable {
    let seed: String
}

struct RandomUserInfo: Codable, Equatable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let birthDate: Birthdate
    let registered: Registration
    let phone: String
    let cell: String
    let id: Identification
    let picture: Picture
    let nationality: String
    
    private enum CodingKeys: String, CodingKey {
        case birthDate = "dob", nationality = "nat", gender, name, location, email, login, phone, cell, id, picture, registered
    }
}

struct Name: Codable, Equatable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable, Equatable {
    let street: Address
    let coordinates: Coordinates
    let timeZone: Timezone
}

struct Address: Codable, Equatable {
    let city: String
    let state: String
    let country: String
    let postcode: Int
}

struct Coordinates: Codable, Equatable {
    let latitude: String
    let longitude: String
}

struct Timezone: Codable, Equatable {
    let description: String
}

struct Login: Codable, Equatable {
    let username: String
    let password: String
}

struct Birthdate: Codable, Equatable {
    let date: String
    let age: Int
}

struct Identification: Codable, Equatable {
    let name: String
    let value: String
}

struct Picture: Codable, Equatable {
    let thumbnail: String
}

struct Registration: Codable, Equatable {
    let date: String
    let age: Int
}
