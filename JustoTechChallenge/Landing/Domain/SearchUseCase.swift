//
//  SearchUseCase.swift
//  JustoTechChallenge
//
//  Created by Natalia Goyes on 31/08/22.
//

import Foundation

protocol SearchUseCaseProtocol: AnyObject {
    func executeSearch(onSuccess: @escaping (RandomUserToDisplay)-> (Void), onError: @escaping (WebServiceError)->(Void))
}

class SearchUseCase {
    
    let getUserInfoService: GetUserInfoServiceProtocol
    let getDisplayableUserService: GetDisplayableUserServiceProtocol
    
    init(getUserInfoService: GetUserInfoServiceProtocol, getDisplayableUserService: GetDisplayableUserServiceProtocol){
        self.getUserInfoService = getUserInfoService
        self.getDisplayableUserService = getDisplayableUserService
    }
    
    
    func processResponse(with infoToProcess: RandomUserAPIResponse, onSuccess: @escaping (RandomUserToDisplay)-> (Void), onError: @escaping (WebServiceError)->(Void)){
        
        getDisplayableUserService.executeSearch(with: infoToProcess) { [weak self] usersToReturn in
            guard let self = self else {
                return
            }
            onSuccess(usersToReturn)
        } onError: { [weak self] webRequestError in
            guard let self = self else {
                return
            }
            onError(.searchFailed)
        }
    }
}

extension SearchUseCase: SearchUseCaseProtocol {
    
    func executeSearch(onSuccess: @escaping (RandomUserToDisplay)-> (Void), onError: @escaping (WebServiceError)->(Void)) {
        
        getUserInfoService.getRandomUserInformation { [weak self] apiResponse in
            guard let self = self else {
                return
            }
            self.processResponse(with: apiResponse, onSuccess: onSuccess, onError: onError)
        } onError: { [weak self] webRequestError in
            guard let self = self else {
                return
            }
            onError(.searchFailed)
        }
    }
}
