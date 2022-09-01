//
//  FakeSearchUseCase.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 1/09/22.
//

import Foundation
@testable import JustoTechChallenge

class FakeSearchUseCase: SearchUseCaseProtocol {

    var successCase = false
    
    let mockedResponse = RandomUserToDisplay(gender: "female", name: "Mrs Natalia Goyes", address: "streetName 1, Medellin -Antioquia. Colombia", location: "(-1.0 ) - (2.4)", email: "anyEmail@any.com", username: "anyUsername", password: "anyPassword", birthdate: "2022-09-01", registeredSince: "2022-09-01", phone: "000-222-333", cell: "332-44-555", id: "SSN - 111", picture: Data(), nationality: "CO")
    
    func executeSearch(onSuccess: @escaping (RandomUserToDisplay) -> (Void), onError: @escaping (WebServiceError) -> (Void)) {
        if successCase {
            onSuccess(mockedResponse)
        } else {
            onError(.searchFailed)
        }
    }
}
