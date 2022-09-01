//
//  FakeRandomUserViewController.swift
//  JustoTechChallengeTests
//
//  Created by Natalia Goyes on 1/09/22.
//

import Foundation
@testable import JustoTechChallenge

class FakeRandomUserViewController: RandomUserViewControllerProtocol {
    
    
    var alertWasInitiated = false
    var viewReloaded = false
    var buttonIsEnabled = false
    var buttonIsDisabled = false
    
    func reloadView(with userInfo: RandomUserToDisplay) {
        viewReloaded = true
    }
    
    func alertDownloadFailed() {
        alertWasInitiated = true
    }
    
    func enableNewUserGeneratorButton() {
        buttonIsEnabled = true
    }
    
    func disableNewUserGeneratorButton() {
        buttonIsDisabled = true
    }
    
}
