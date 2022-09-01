//
//  URLRequestBuilderTests.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 31/08/22.
//

import XCTest
@testable import JustoTechChallenge

class URLRequestBuilderTests: XCTestCase {
    
    private var sut: URLRequestBuilder!

    override func setUp() {
        super.setUp()
        sut = URLRequestBuilder()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_buildURLisCalled_GIVEN_noEndpoint_THEN_itShouldThrowinvalidURLError() throws {
        do {
            let _ = try sut.build()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! URLRequestBuilder.Error, URLRequestBuilder.Error.noEndpoint)
        }
    }
    
    func test_WHEN_buildURLisCalled_GIVEN_failingEndpoint_THEN_itShouldThrowinvalidURLError() throws {

        let anyInvalidEndpoint = BaseEndpoint(path: " ", queryItems: [], httpMethod: .GET)
        do {
            sut.setEndpoint(endpoint: anyInvalidEndpoint)
            let _ = try sut.build()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! URLRequestBuilder.Error, URLRequestBuilder.Error.noURL)
        }
    }

    
    func test_WHEN_buildURLisInvoked_GIVEN_validEndpoint_THEN_itShouldReturnURLRequest() throws {

        let anyValidEndpoint = RandomUserEndpoint()

        do {
            sut.setEndpoint(endpoint: anyValidEndpoint)
            let urlRequest = try sut.build()
            XCTAssertTrue(urlRequest is URLRequest)
        } catch {
            XCTFail()
        }
    }

}
