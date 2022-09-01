//
//  GetUserInfoServiceTests.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 1/09/22.
//

import XCTest
@testable import JustoTechChallenge

class GetUserInfoServiceTests: XCTestCase {

    private var sut: GetUserInfoService!
    private var fakeURLRequestBuilder: FakeURLRequestBuilder!
    private var fakeRESTClient: FakeRESTClient!
    
    override func setUp() {
        super.setUp()
        fakeURLRequestBuilder = FakeURLRequestBuilder()
        fakeRESTClient = FakeRESTClient()
        sut = GetUserInfoService(urlRequestBuilder: fakeURLRequestBuilder, restClient: fakeRESTClient)
    }
    
    override func tearDown() {
        fakeURLRequestBuilder = nil
        fakeRESTClient = nil
        sut = nil
        super.tearDown()
    }

    func test_WHEN_getRandomUserInformationIsCalled_GIVEN_failedURL_THEN_itShouldReturnSearchFailedError(){

        fakeURLRequestBuilder.successCase = false
        fakeRESTClient.userInfoWasCalled = true
      
        sut.getRandomUserInformation {  _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }

    func test_WHEN_getRandomUserInformationIsCalled_GIVEN_successfulURLAndRESTResponse_THEN_itShouldReturnAPIResponse(){

        fakeURLRequestBuilder.successCase = true
        fakeRESTClient.successCase = true
        fakeRESTClient.userInfoWasCalled = true

        let location = Location(street: Address(number: 1, name: "streetName"), coordinates: Coordinates(latitude: "-1.0", longitude: "2.4"), timezone: Timezone(description: "GMT-5"), city: "Medellin", state: "Antioquia", country: "Colombia")
        let results = [RandomUserInfo(gender: "female", name: Name(title: "Mrs", first: "Natalia", last: "Goyes"), location: location, email: "anyEmail@any.com", login: Login(username: "anyUsername", password: "anyPassword"), birthDate: Birthdate(date: "2022-09-01", age: 20), registered: Registration(date: "2022-09-01", age: 20), phone: "000-222-333", cell: "332-44-555", id: Identification(name: "SSN", value: "111"), picture: Picture(large: "anypictureURL"), nationality: "CO")]
        let pagination = PaginationInfo(seed: "")
        let expectedResponse = RandomUserAPIResponse(results: results, info: pagination)

        sut.getRandomUserInformation {  response in
            XCTAssertEqual(response, expectedResponse)
        } onError: { _ in
            XCTFail()
        }
    }

    func test_WHEN_getRandomUserInformationIsCalled_GIVEN_successfulURLAndFailedRESTResponse_THEN_itShouldReturnSearchFailedError(){

        fakeURLRequestBuilder.successCase = true
        fakeRESTClient.successCase = false
        fakeRESTClient.userInfoWasCalled = true
        
        sut.getRandomUserInformation {  _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
    
}
