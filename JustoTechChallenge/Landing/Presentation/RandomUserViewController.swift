//
//  RandomUserViewController.swift
//  JustoTechChallenge
//
//  Created by Natalia Goyes on 31/08/22.
//

import UIKit

protocol RandomUserViewControllerProtocol: AnyObject {
    func reloadView(with userInfo: RandomUserToDisplay)
    func alertDownloadFailed()
    func enableNewUserGeneratorButton()
    func disableNewUserGeneratorButton()
}

class RandomUserViewController: UIViewController {
    
    var presenter: RandomUserPresenterProtocol?
    
    struct Constant {
        static let alertDownloadingFailedTitle = "Error"
        static let alertDownloadingFailedTitleMessage = "New user could not be downloaded"
        static let okAction = "Retry"
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var birthDateLabel: UILabel!
    
    @IBOutlet weak var nationalityLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!

    @IBOutlet weak var idLabel: UILabel!

    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var paswordLabel: UILabel!
    
    @IBOutlet weak var registeredSinceDateLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var latitudLongitudLAbel: UILabel!
    
    @IBOutlet weak var zipcodeLabel: UILabel!
    
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
        presenter?.requestRandomUser()
    }
    
    
    func fillThumbnail(with userInfo: RandomUserToDisplay){
        self.imageView.image = UIImage(data: userInfo.picture)
    }
    
    func fillPersonalInformation(with userInfo: RandomUserToDisplay) {
        self.fullNameLabel.text = userInfo.name
        self.birthDateLabel.text = "Birth date: \(userInfo.birthdate)"
        self.nationalityLabel.text = "Nationality: \(userInfo.nationality)"
        self.genderLabel.text = "Gender: \(userInfo.gender)"
        self.idLabel.text = "Identification \(userInfo.id)"
    }
    
    func fillContactData(with userInfo: RandomUserToDisplay) {
        self.emailLabel.text = "Email: \(userInfo.email)"
        self.phoneLabel.text = "Phone: \(userInfo.phone)"
        self.cellLabel.text = "Cellphone: \(userInfo.cell)"
    }
    
    func fillLoginDetails(with userInfo: RandomUserToDisplay){
        self.usernameLabel.text = "Username: \(userInfo.username)"
        self.paswordLabel.text = "Password: \(userInfo.password)"
        self.registeredSinceDateLabel.text = "Registered since: \(userInfo.registeredSince)"
    }
    
    func fillLocationInformation(with userInfo: RandomUserToDisplay){
        self.addressLabel.text = userInfo.address
        self.latitudLongitudLAbel.text = userInfo.location
    }
    
    func fillNewUserData(with userInfo: RandomUserToDisplay){
        self.fillThumbnail(with: userInfo)
        self.fillPersonalInformation(with: userInfo)
        self.fillContactData(with: userInfo)
        self.fillLoginDetails(with: userInfo)
        self.fillLocationInformation(with: userInfo)
    }
    
}

extension RandomUserViewController: RandomUserViewControllerProtocol {
    
    func reloadView(with userInfo: RandomUserToDisplay) {
        self.fillNewUserData(with: userInfo)
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
