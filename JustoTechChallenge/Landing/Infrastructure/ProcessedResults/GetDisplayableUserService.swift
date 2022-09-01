//
//  GetDisplayableUserService.swift
//  JustoTechChallenge
//
//  Created by Natalia Goyes on 31/08/22.
//

import Foundation

protocol GetDisplayableUserServiceProtocol: AnyObject {
    func executeSearch(with userInfo: RandomUserAPIResponse, onSuccess: @escaping (RandomUserToDisplay)-> (Void), onError: @escaping (WebServiceError)->(Void))
}

class GetDisplayableUserService {
    
    struct Constant {
        static let indexUserToRetrieve = 0
    }
    
    let getThumbnailService: GetThumbnailDataServiceProtocol
    let informationPrepService: InformationPrepServiceProtocol
    
    var usersToReturn : [RandomUserToDisplay] = []
    
    init(getThumbnailService: GetThumbnailDataServiceProtocol, informationPrepService: InformationPrepServiceProtocol) {
        self.getThumbnailService = getThumbnailService
        self.informationPrepService = informationPrepService
    }
    
}

extension GetDisplayableUserService: GetDisplayableUserServiceProtocol {
    
    func executeSearch(with userInfo: RandomUserAPIResponse, onSuccess: @escaping (RandomUserToDisplay)-> (Void), onError: @escaping (WebServiceError)->(Void)){
        
        let userToEvaluate =  userInfo.results[0]
        
        getThumbnailService.getThumbnail(from: userToEvaluate.picture.large) { [weak self] thumbnailData in
            guard let self = self else {
                return
            }
            let newUser = self.informationPrepService.mapProductsResults(from: userToEvaluate, and: thumbnailData)
            onSuccess(newUser)
        } onError: { [weak self] webRequestError in
            guard let self = self else {
                return
            }
            onError(.searchFailed)
        }
    }
}
