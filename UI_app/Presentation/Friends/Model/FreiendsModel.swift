//
//  FreiendsModel.swift
//  UI_app
//
//  Created by Вячеслав on 03.11.2021.
//

import Foundation
import RealmSwift


class FriendsModel: Object, Codable {
    
    @objc dynamic var id: Int
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var bdate: String?
  
    var fullName: String {
        firstName + " " + lastName
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case photo100 = "photo_100"

    }

}







