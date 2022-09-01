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
}

class RandomUserPresenter {
    
    enum Error: Swift.Error {
        case incompleteDataToSearch, noResults, errorShowingData
    }
    
    weak var viewController: RandomUserViewControllerProtocol?
    
    var searchUseCase: SearchUseCaseProtocol
    
    init(searchUseCase: SearchUseCaseProtocol){
        self.searchUseCase = searchUseCase
    }
    
}

extension RandomUserPresenter: RandomUserPresenterProtocol {
    
    func setViewController(_ viewController: RandomUserViewControllerProtocol){
        self.viewController = viewController
    }
    
    func requestRandomUser() {
        viewController?.disableNewUserGeneratorButton()
        searchUseCase.executeSearch {[weak self] randomUser in
            guard let self = self, let controller = self.viewController else {
                return
            }
            controller.enableNewUserGeneratorButton()
            controller.reloadView(with: randomUser)
        } onError: { [weak self] errorThrown in
            guard let self = self, let controller = self.viewController else {
                return
            }
            controller.enableNewUserGeneratorButton()
            controller.alertDownloadFailed()
        }
    }
}
