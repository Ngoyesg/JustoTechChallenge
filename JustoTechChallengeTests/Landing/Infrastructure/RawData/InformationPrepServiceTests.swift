//
//  InformationPrepServiceTests.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 1/09/22.
//

import XCTest
@testable import JustoTechChallenge

class InformationPrepServiceTests: XCTestCase {

    private var sut: InformationPrepService!
    
    override func setUp() {
        super.setUp()
        sut = InformationPrepService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_mapProductsResultsIsCalled_GIVEN_validUserInfo_THEN_itShouldReturnData(){
        
        let location = Location(street: Address(number: 1, name: "streetName"), coordinates: Coordinates(latitude: "-1.0", longitude: "2.4"), timezone: Timezone(description: "GMT-5"), city: "Medellin", state: "Antioquia", country: "Colombia")
        let results = [RandomUserInfo(gender: "female", name: Name(title: "Mrs", first: "Natalia", last: "Goyes"), location: location, email: "anyEmail@any.com", login: Login(username: "anyUsername", password: "anyPassword"), birthDate: Birthdate(date: "2022-09-01", age: 20), registered: Registration(date: "2022-09-01", age: 20), phone: "000-222-333", cell: "332-44-555", id: Identification(name: "SSN", value: "111"), picture: Picture(large: "anypictureURL"), nationality: "CO")]
        let pagination = PaginationInfo(seed: "")
        let mockAPIResponse = RandomUserAPIResponse(results: results, info: pagination)
                
        let expectedUserInfo = RandomUserToDisplay(gender: "female", name: "Mrs Natalia Goyes", address: "streetName 1, Medellin -Antioquia. Colombia", location: "(-1.0 ) - (2.4)", email: "anyEmail@any.com", username: "anyUsername", password: "anyPassword", birthdate: "2022-09-01", registeredSince: "2022-09-01", phone: "000-222-333", cell: "332-44-555", id: "SSN - 111", picture: Data(), nationality: "CO")
        
        let response = sut.mapProductsResults(from: mockAPIResponse.results[0], and: Data())
        
        XCTAssertEqual(response, expectedUserInfo)
        
    }


}
