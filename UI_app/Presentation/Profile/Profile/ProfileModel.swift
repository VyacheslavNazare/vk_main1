//
//  ProfileModel.swift
//  UI_app
//
//  Created by Вячеслав on 27.11.2021.
//

import Foundation
//import RealmSwift

class ProfileModel: Codable {

   var firstName: String = ""
    var lastName: String = ""
    var photo100: URL
    var bDate: String = ""
    var fullName: String {
        firstName + " " + lastName
    }
    
    enum CodingKeys: String, CodingKey {

        case firstName = "first_name"
        case lastName = "last_name"
        case photo100 = "photo_100"
        case bDate = "bdate"

    }
}
