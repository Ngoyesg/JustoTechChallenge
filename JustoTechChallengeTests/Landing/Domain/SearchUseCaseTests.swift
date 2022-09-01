//
//  SearchUseCaseTests.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 1/09/22.
//

import XCTest
@testable import JustoTechChallenge

class SearchUseCaseTests: XCTestCase {

    private var sut: SearchUseCase!
    private var fakeGetUserInfoService: FakeGetUserInfoService!
    private var fakeGetDisplayableUserService: FakeGetDisplayableUserService!
    
    override func setUp() {
        super.setUp()
        fakeGetUserInfoService = FakeGetUserInfoService()
        fakeGetDisplayableUserService = FakeGetDisplayableUserService()
        sut = SearchUseCase(getUserInfoService: fakeGetUserInfoService, getDisplayableUserService: fakeGetDisplayableUserService)
    }
    
    override func tearDown() {
        fakeGetUserInfoService = nil
        fakeGetDisplayableUserService = nil
        sut = nil
        super.tearDown()
    }
    
    
    func test_WHEN_executeSearchIsCalled_GIVEN_onSuccessCaseOnDisplayableServiceAndFailedUserInfoService_THEN_itShouldThrowWebServiceError(){
        fakeGetUserInfoService.successCase = false
        fakeGetDisplayableUserService.successCase = true
        
        sut.executeSearch { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }

    func test_WHEN_executeSearchIsCalled_GIVEN_failedCaseOnDisplayableServiceAndFailedUserInfoService_THEN_itShouldThrowWebServiceError(){
        
        fakeGetUserInfoService.successCase = false
        fakeGetDisplayableUserService.successCase = false
        sut.executeSearch { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }


    func test_WHEN_executeSearchIsCalled_GIVEN_failedCaseOnDisplayableServiceAndSuccessUserInfoService_THEN_itShouldThrowWebServiceError(){
        fakeGetUserInfoService.successCase = true
        fakeGetDisplayableUserService.successCase = false
        sut.executeSearch { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }

    func test_WHEN_executeSearchIsCalled_GIVEN_onSuccessCaseOnBothServices_THEN_itShouldREturnProductsToDisplay(){
        fakeGetUserInfoService.successCase = true
        fakeGetDisplayableUserService.successCase = false
        
        let expectedResponse = RandomUserToDisplay(gender: "female", name: "Mrs Natalia Goyes", address: "streetName 1, Medellin -Antioquia. Colombia", location: "(-1.0 ) - (2.4)", email: "anyEmail@any.com", username: "anyUsername", password: "anyPassword", birthdate: "2022-09-01", registeredSince: "2022-09-01", phone: "000-222-333", cell: "332-44-555", id: "SSN - 111", picture: Data(), nationality: "CO")
        
        sut.executeSearch { response in
            XCTAssertEqual(response, expectedResponse)
        } onError: { _ in
            XCTFail()
        }
    }
}
