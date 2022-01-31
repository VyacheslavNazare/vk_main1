//
//  GroupStruct.swift
//  UI_app
//
//  Created by Вячеслав on 28.10.2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let groupModel = try? newJSONDecoder().decode(GroupModel.self, from: jsonData)

import Foundation
import RealmSwift
// MARK: - GroupModel
struct GroupJSON: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [GroupModel]
}

// MARK: - Item
class GroupModel: Codable {
    @objc dynamic var isMember, id: Int
    @objc dynamic var photo100: String
    @objc dynamic var isAdvertiser, isAdmin: Int
    @objc dynamic var photo50, photo200: URL
    @objc dynamic var type, screenName, name: String
    @objc dynamic var isClosed: Int
    @objc dynamic var description: String

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
        case description = "description"
    }
}
