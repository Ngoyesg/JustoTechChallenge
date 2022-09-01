//
//  FakeGetThumbnailDataService.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 1/09/22.
//

import Foundation
@testable import JustoTechChallenge

class FakeGetThumbnailDataService: GetThumbnailDataServiceProtocol {
    
    var successCase = false
    let mockedData = Data()
    
    func getThumbnail(from text: String, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void) {
        if successCase {
            onSuccess(mockedData)
        } else {
            onError(.searchFailed)
        }
    }
}
