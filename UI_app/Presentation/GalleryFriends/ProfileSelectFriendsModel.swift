//
//  ProfileSelectFriendsModel.swift
//  UI_app
//
//  Created by Вячеслав on 13.01.2022.
//

import Foundation


class ProfileSelectFriendsModel: Codable {

    var firstName: String = ""
    var lastName: String = ""
    var photo100: URL!
    var bdate: String = ""
    var sex: Int
    var fullName: String {
        firstName + " " + lastName
    }
    
    enum CodingKeys: String, CodingKey {

        case firstName = "first_name"
        case lastName = "last_name"
        case photo100 = "photo_100"
        case bdate = "bdate"
        case sex = "sex"
    }
}

