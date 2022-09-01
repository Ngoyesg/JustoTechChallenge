//
//  FakeInformationPrepService.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 1/09/22.
//

import Foundation
@testable import JustoTechChallenge

class FakeInformationPrepService: InformationPrepServiceProtocol {
    
    func mapProductsResults(from user: RandomUserInfo, and thumbnail: Data) -> RandomUserToDisplay {
        
        let location = Location(street: Address(number: 1, name: "streetName"), coordinates: Coordinates(latitude: "-1.0", longitude: "2.4"), timezone: Timezone(description: "GMT-5"), city: "Medellin", state: "Antioquia", country: "Colombia")
        let results = [RandomUserInfo(gender: "female", name: Name(title: "Mrs", first: "Natalia", last: "Goyes"), location: location, email: "anyEmail@any.com", login: Login(username: "anyUsername", password: "anyPassword"), birthDate: Birthdate(date: "2022-09-01", age: 20), registered: Registration(date: "2022-09-01", age: 20), phone: "000-222-333", cell: "332-44-555", id: Identification(name: "SSN", value: "111"), picture: Picture(large: "anypictureURL"), nationality: "CO")]
        let pagination = PaginationInfo(seed: "")
        let mockUser = RandomUserAPIResponse(results: results, info: pagination)
        
        let user = mockUser.results[0]
        
        return RandomUserToDisplay(gender: user.gender, name: user.name.first, address: user.location.street.name, location: user.location.coordinates.latitude, email: user.email, username: user.login.username, password: user.login.password, birthdate: user.birthDate.date, registeredSince: user.registered.date, phone: user.phone, cell: user.cell, id: user.id.name, picture: Data(), nationality: user.nationality)
    }
}
