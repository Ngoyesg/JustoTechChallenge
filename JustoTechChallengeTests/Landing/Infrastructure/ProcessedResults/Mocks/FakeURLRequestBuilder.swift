//
//  FakeURLRequestBuilder.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 1/09/22.
//

import Foundation
@testable import JustoTechChallenge

class FakeRESTClient: WebClientProtocol {

    var successCase = false
    var performRequestWasCalled = false
    var userInfoWasCalled = false

    private func getEncodedUserData() -> Data {
        let location = Location(street: Address(number: 1, name: "streetName"), coordinates: Coordinates(latitude: "-1.0", longitude: "2.4"), timezone: Timezone(description: "GMT-5"), city: "Medellin", state: "Antioquia", country: "Colombia")
        let results = [RandomUserInfo(gender: "female", name: Name(title: "Mrs", first: "Natalia", last: "Goyes"), location: location, email: "anyEmail@any.com", login: Login(username: "anyUsername", password: "anyPassword"), birthDate: Birthdate(date: "2022-09-01", age: 20), registered: Registration(date: "2022-09-01", age: 20), phone: "000-222-333", cell: "332-44-555", id: Identification(name: "SSN", value: "111"), picture: Picture(large: "anypictureURL"), nationality: "CO")]
        let pagination = PaginationInfo(seed: "")
        let mockSucess = RandomUserAPIResponse(results: results, info: pagination)
        let encoder = JSONEncoder()
        let encodedData = try! encoder.encode(mockSucess.self)
        return encodedData
    }
    
    func performRequest(request: URLRequest, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void) {
        performRequestWasCalled = true
        
        if (successCase) {
            let dataToReturn = userInfoWasCalled ? getEncodedUserData() : Data()
            onSuccess(dataToReturn)
        } else {
            onError(WebServiceError.searchFailed)
        }
    }
}
