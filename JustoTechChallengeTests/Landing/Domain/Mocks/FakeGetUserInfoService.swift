//
//  FakeGetUserInfoService.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 1/09/22.
//

import Foundation
@testable import JustoTechChallenge

class FakeGetUserInfoService: GetUserInfoServiceProtocol {

    var successCase = false
 
    let mockAPIResponse = RandomUserAPIResponse(results: [RandomUserInfo(gender: "female", name: Name(title: "Mrs", first: "Natalia", last: "Goyes"), location: Location(street: Address(number: 1, name: "streetName"), coordinates: Coordinates(latitude: "-1.0", longitude: "2.4"), timezone: Timezone(description: "GMT-5"), city: "Medellin", state: "Antioquia", country: "Colombia"), email: "anyEmail@any.com", login: Login(username: "anyUsername", password: "anyPassword"), birthDate: Birthdate(date: "2022-09-01", age: 20), registered: Registration(date: "2022-09-01", age: 20), phone: "000-222-333", cell: "332-44-555", id: Identification(name: "SSN", value: "111"), picture: Picture(large: "anypictureURL"), nationality: "CO")], info:  PaginationInfo(seed: ""))
    
    func getRandomUserInformation(onSuccess: @escaping (RandomUserAPIResponse) -> Void, onError: @escaping (WebServiceError) -> Void) {
        if successCase {
            onSuccess(mockAPIResponse)
        } else {
            onError(.searchFailed)
        }
    }
}
