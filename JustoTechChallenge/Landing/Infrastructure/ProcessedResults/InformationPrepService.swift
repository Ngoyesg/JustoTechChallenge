//
//  InformationPrepService.swift
//  JustoTechChallenge
//
//  Created by Natalia Goyes on 31/08/22.
//

import Foundation

protocol InformationPrepServiceProtocol: AnyObject {
    func mapProductsResults(from user: RandomUserInfo, and thumbnail: Data) -> RandomUserToDisplay
}

class InformationPrepService {
    
    struct Constant {
        static let dateLength = 10
    }
      
}

extension InformationPrepService: InformationPrepServiceProtocol {
    
    func mapProductsResults(from user: RandomUserInfo, and thumbnail: Data) -> RandomUserToDisplay {
        
        let fullname = "\(user.name.title) \(user.name.first) \(user.name.last)"

        let address = "\(user.location.street.name) \(user.location.street.number), \(user.location.city) -\(user.location.state). \(user.location.country)"
        
        let location = "(\(user.location.coordinates.latitude) ) - (\(user.location.coordinates.longitude))"
        
        let birthdate = "\(user.birthDate.date.prefix(Constant.dateLength))"
        
        let registeredSince = "\(user.registered.date.prefix(Constant.dateLength))"
        
        var id = "Unknown ID"
        
        if let value = user.id.value {
            id = "\(user.id.name) - \(value)"
        }
        
        return RandomUserToDisplay(gender: user.gender, name: fullname, address: address, location: location, email: user.email, username: user.login.username, password: user.login.password, birthdate: birthdate, registeredSince: registeredSince, phone: user.phone, cell: user.cell, id: id, picture: thumbnail, nationality: user.nationality)
    }
    
}
    


