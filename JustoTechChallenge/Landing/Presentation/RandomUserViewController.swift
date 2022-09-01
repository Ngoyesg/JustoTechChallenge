//
//  RandomUserViewController.swift
//  JustoTechChallenge
//
//  Created by Natalia Goyes on 31/08/22.
//

import UIKit

protocol RandomUserViewControllerProtocol: AnyObject {
    func reloadView()
    func alertDownloadFailed()
    func enableNewUserGeneratorButton()
    func disableNewUserGeneratorButton()
}

class RandomUserViewController: UIViewController {
    
    var presenter: RandomUserPresenterProtocol?
    
    struct Constant {
        static let alertDownloadingFailedTitle = "Error"
        static let alertDownloadingFailedTitleMessage = "New user user could not be downloaded"
        static let okAction = "Retry"
    }
    
    @IBOutlet weak var newUserButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = RandomUserPresenterBuilder().build()
        self.presenter?.setViewController(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter?.requestRandomUser()
    }
    
    @IBAction func onNewButttonClicked(_ sender: Any) {
        presenter?.processGenerateRandomUser()
    }
    
    
    
}

extension RandomUserViewController: RandomUserViewControllerProtocol {
    
    func reloadView() {
        //do something
    }
    
    
    func alertDownloadFailed(){
        let alert = UIAlertController(title: Constant.alertDownloadingFailedTitle, message: Constant.alertDownloadingFailedTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func enableNewUserGeneratorButton(){
        self.newUserButton.isEnabled = true
    }
    
    func disableNewUserGeneratorButton(){
        self.newUserButton.isEnabled = false
    }
    
}
