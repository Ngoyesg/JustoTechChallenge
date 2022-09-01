//
//  GetDisplayableUserService.swift
//  JustoTechChallenge
//
//  Created by Natalia Goyes on 31/08/22.
//

import Foundation

protocol GetDisplayableUserServiceProtocol: AnyObject {
    func executeSearch(with userInfo: RandomUserAPIResponse, onSuccess: @escaping ([RandomUserToDisplay])-> (Void), onError: @escaping (WebServiceError)->(Void))
}

class GetDisplayableUserService {
    
    struct Constant {
        static let dateLength = 10
        static let dispatchQueue = "Thumbnail"
    }
      
    let getThumbnailService: GetThumbnailDataServiceProtocol
    let informationPrepService: InformationPrepServiceProtocol
    
    var usersToReturn : [RandomUserToDisplay] = []
    let dispatchGroup = DispatchGroup()
    let dipatchQueue = DispatchQueue(label: Constant.dispatchQueue)
    var error = false
    
    init(getThumbnailService: GetThumbnailDataServiceProtocol, informationPrepService: InformationPrepServiceProtocol) {
        self.getThumbnailService = getThumbnailService
        self.informationPrepService = informationPrepService
    }
    
}

extension GetDisplayableUserService: GetDisplayableUserServiceProtocol {
    
    func executeSearch(with userInfo: RandomUserAPIResponse, onSuccess: @escaping ([RandomUserToDisplay])-> (Void), onError: @escaping (WebServiceError)->(Void)){
        
       error = false
   
        userInfo.users.forEach { user in
            dipatchQueue.async {
                self.dispatchGroup.enter()
                self.getThumbnailService.getThumbnail(from: user.picture.thumbnail) { [weak self] thumbnailData in
                    guard let self = self else {
                        return
                    }
                    let newUser = self.informationPrepService.mapProductsResults(from: user, and: thumbnailData)
                    self.usersToReturn.append(newUser)
                    self.dispatchGroup.leave()
                } onError: { [weak self] webRequestError in
                    guard let self = self else {
                        return
                    }
                    self.dispatchGroup.leave()
                    self.error = true
                }
            }
        }
        
        dispatchGroup.notify(queue: dipatchQueue) {
            DispatchQueue.main.async {
                if self.error {
                    onError(.searchFailed)
                } else {
                    onSuccess(self.usersToReturn)
                }
            }
        }
    }
}
