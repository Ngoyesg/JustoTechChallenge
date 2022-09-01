//
//  RandomUserPresenterBuilder.swift
//  JustoTechChallenge
//
//  Created by Natalia Goyes on 31/08/22.
//

import Foundation

class RandomUserPresenterBuilder {
    
    func build() -> RandomUserPresenterProtocol {
        
        let urlRequestBuilder = URLRequestBuilder()
        
        let restClient = RESTClient()
        
        let getThumbnailService = GetThumbnailDataService(restClient: restClient)
        
        let informationPrepService = InformationPrepService()
        
        let getDisplayableUserService = GetDisplayableUserService(getThumbnailService: getThumbnailService, informationPrepService: informationPrepService)
        
        let getUserInfoService = GetUserInfoService(urlRequestBuilder: urlRequestBuilder, restClient: restClient)
        
        let searchUseCase = SearchUseCase(getUserInfoService: getUserInfoService, getDisplayableUserService: getDisplayableUserService)
        
        return RandomUserPresenter(searchUseCase: searchUseCase)
        
    }
}
