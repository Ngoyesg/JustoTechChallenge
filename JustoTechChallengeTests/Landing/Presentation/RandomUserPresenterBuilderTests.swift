//
//  RandomUserPresenterBuilderTests.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 31/08/22.
//

import XCTest
@testable import JustoTechChallenge

class RandomUserPresenterBuilderTests: XCTestCase {

    private var sut: RandomUserPresenterBuilder!
    
    override func setUp() {
        super.setUp()
        sut = RandomUserPresenterBuilder()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_buildIsCalled_THEN_itShouldReturnRandomUserPresenter() {
        let presenter = sut.build()
        XCTAssertTrue(presenter is RandomUserPresenter)
    }

}
