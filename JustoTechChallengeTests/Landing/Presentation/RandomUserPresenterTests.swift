//
//  RandomUserPresenterTests.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 31/08/22.
//

import XCTest
@testable import JustoTechChallenge

class RandomUserPresenterTests: XCTestCase {

    private var sut: RandomUserPresenter!
    private var fakeSearchUseCase: FakeSearchUseCase!
    
    override func setUp() {
        super.setUp()
        fakeSearchUseCase = FakeSearchUseCase()
        sut = RandomUserPresenter(searchUseCase: fakeSearchUseCase)
    }
    
    override func tearDown() {
        fakeSearchUseCase = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_setViewControllerIsCalled_GIVEN_aValidViewController_THEN_itShouldReturnTrue(){
        let fakeViewController = FakeRandomUserViewController()
        sut.setViewController(fakeViewController)
        XCTAssertTrue(sut.viewController is RandomUserViewControllerProtocol)
    }
    
    func  test_WHEN_requestRandomUserIsCalled_GIVEN_searchFailed_THEN_alertDownloadFailedShouldBeTrueButtonShouldBeEnabled(){
        fakeSearchUseCase.successCase = false
        let fakeViewController = FakeRandomUserViewController()
        sut.setViewController(fakeViewController)

        sut.requestRandomUser()
        XCTAssertTrue(fakeViewController.alertWasInitiated)
        XCTAssertFalse(fakeViewController.buttonIsEnabled)
    }
    
    func test_WHEN_requestRandomUserIsCalled_GIVEN_searchSucceded_THEN_controllerReloadedShouldBeTrueButtonShouldBeEnabled(){
        fakeSearchUseCase.successCase = true
        let fakeViewController = FakeRandomUserViewController()
        sut.setViewController(fakeViewController)

        sut.requestRandomUser()
        XCTAssertTrue(fakeViewController.viewReloaded)
        XCTAssertFalse(fakeViewController.buttonIsEnabled)
    }
}
