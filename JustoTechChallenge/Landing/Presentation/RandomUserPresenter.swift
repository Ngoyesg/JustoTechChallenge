//
//  RandomUserPresenter.swift
//  JustoTechChallenge
//
//  Created by Natalia Goyes on 31/08/22.
//

import Foundation

protocol RandomUserPresenterProtocol: AnyObject {
    func setViewController(_ viewController: RandomUserViewControllerProtocol)
    func requestRandomUser()
    func processGenerateRandomUser()
}

class RandomUserPresenter {
    
    enum Error: Swift.Error {
        case incompleteDataToSearch, noResults, errorShowingData
    }
    
    weak var viewController: RandomUserViewControllerProtocol?
    
    var searchUseCase: SearchUseCaseProtocol
    
    var randomUsersToDisplay: [RandomUserToDisplay] = []
    
    init(searchUseCase: SearchUseCaseProtocol){
        self.searchUseCase = searchUseCase
    }
    
    func clearInformation() {
        self.randomUsersToDisplay = []
    }
}

extension RandomUserPresenter: RandomUserPresenterProtocol {
    
    func setViewController(_ viewController: RandomUserViewControllerProtocol){
        self.viewController = viewController
    }
    
    func requestRandomUser() {
        viewController?.disableNewUserGeneratorButton()
        searchUseCase.executeSearch {[weak self] randomUsers in
            guard let self = self, let controller = self.viewController else {
                return
            }
            self.randomUsersToDisplay = randomUsers
            controller.enableNewUserGeneratorButton()
            controller.reloadView()
        } onError: { [weak self] errorThrown in
            guard let self = self, let controller = self.viewController else {
                return
            }
            controller.enableNewUserGeneratorButton()
            controller.alertDownloadFailed()
        }
    }
    
    func processGenerateRandomUser() {
        self.clearInformation()
        self.requestRandomUser()
    }
}
