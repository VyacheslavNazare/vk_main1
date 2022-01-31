//
//  GalleryGroupModel.swift
//  UI_app
//
//  Created by Вячеслав on 18.01.2022.
//

import Foundation
// MARK: - PhotoModel
struct PhotooGroupJSON: Codable {
    let response: ResponseeGroupPhoto
}

// MARK: - Response
struct ResponseeGroupPhoto: Codable {
    let count: Int
    let items: [GroupPhotoStruct]
}

// MARK: - Item
struct GroupPhotoStruct: Codable {
    let albumID: Int
    let id, date: Int
    let text: String
    let sizes: [Size1]
    let likes: Likes1
    let lat, long: Double?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text, sizes
        case likes, lat, long
    }
}

// MARK: - Likes
struct Likes1: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}


// MARK: - Size
struct Size1: Codable {
    let width, height: Int
    let url: URL
    let type: String
}

