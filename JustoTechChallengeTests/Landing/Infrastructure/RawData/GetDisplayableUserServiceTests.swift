//
//  GetDisplayableUserServiceTests.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 1/09/22.
//

import XCTest
@testable import JustoTechChallenge

class GetDisplayableUserServiceTests: XCTestCase {

    private var sut: GetDisplayableUserService!
    private var fakeGetThumbnailService: FakeGetThumbnailDataService!
    private var fakeInformationPrepService: FakeInformationPrepService!
    
    override func setUp() {
        super.setUp()
        fakeInformationPrepService = FakeInformationPrepService()
        fakeGetThumbnailService = FakeGetThumbnailDataService()
        sut = GetDisplayableUserService(getThumbnailService: fakeGetThumbnailService, informationPrepService: fakeInformationPrepService)
    }
    
    override func tearDown() {
        fakeInformationPrepService = nil
        fakeGetThumbnailService = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_executeSearchIsCalled_GIVEN_successCase_THEN_itShouldReturnUserToDisplay(){
        let location = Location(street: Address(number: 1, name: "streetName"), coordinates: Coordinates(latitude: "-1.0", longitude: "2.4"), timezone: Timezone(description: "GMT-5"), city: "Medellin", state: "Antioquia", country: "Colombia")
        let results = [RandomUserInfo(gender: "female", name: Name(title: "Mrs", first: "Natalia", last: "Goyes"), location: location, email: "anyEmail@any.com", login: Login(username: "anyUsername", password: "anyPassword"), birthDate: Birthdate(date: "2022-09-01", age: 20), registered: Registration(date: "2022-09-01", age: 20), phone: "000-222-333", cell: "332-44-555", id: Identification(name: "SSN", value: "111"), picture: Picture(large: "anypictureURL"), nationality: "CO")]
        let pagination = PaginationInfo(seed: "")
        let mockAPIResponse = RandomUserAPIResponse(results: results, info: pagination)
        
        let user = mockAPIResponse.results[0]
        
        let expectedUserInfo = RandomUserToDisplay(gender: user.gender, name: user.name.first, address: user.location.street.name, location: user.location.coordinates.latitude, email: user.email, username: user.login.username, password: user.login.password, birthdate: user.birthDate.date, registeredSince: user.registered.date, phone: user.phone, cell: user.cell, id: user.id.name, picture: Data(), nationality: user.nationality)
        
        fakeGetThumbnailService.successCase = true
        
        sut.executeSearch(with: mockAPIResponse) { response in
            XCTAssertEqual(response, expectedUserInfo)
        } onError: { _ in
            XCTFail()
        }

    }

    func test_WHEN_executeSearchIsCalled_GIVEN_failedCase_THEN_itShouldReturnUserToDisplay(){
        let location = Location(street: Address(number: 1, name: "streetName"), coordinates: Coordinates(latitude: "-1.0", longitude: "2.4"), timezone: Timezone(description: "GMT-5"), city: "Medellin", state: "Antioquia", country: "Colombia")
        let results = [RandomUserInfo(gender: "female", name: Name(title: "Mrs", first: "Natalia", last: "Goyes"), location: location, email: "anyEmail@any.com", login: Login(username: "anyUsername", password: "anyPassword"), birthDate: Birthdate(date: "2022-09-01", age: 20), registered: Registration(date: "2022-09-01", age: 20), phone: "000-222-333", cell: "332-44-555", id: Identification(name: "SSN", value: "111"), picture: Picture(large: "anypictureURL"), nationality: "CO")]
        let pagination = PaginationInfo(seed: "")
        let mockAPIResponse = RandomUserAPIResponse(results: results, info: pagination)

        fakeGetThumbnailService.successCase = false

        sut.executeSearch(with: mockAPIResponse) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
    
}
