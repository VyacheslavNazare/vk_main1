//
//  MyPhotoModel.swift
//  UI_app
//
//  Created by Вячеслав on 30.11.2021.
//

import Foundation
// MARK: - PhotoModel
struct MyPhotoJSON: Codable {
    let response: MyResponsePhoto
}

// MARK: - Response
struct MyResponsePhoto: Codable {
    let count: Int
    let items: [MyPhotoStruct]
}

// MARK: - Item
struct MyPhotoStruct: Codable {
    let albumID: Int
    let postID: Int?
    let id, date: Int
    let text: String
    let sizes: [MySize]
    let likes: MyLikes
    let lat, long: Double?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text, sizes
        case likes, lat, long
    }
}

// MARK: - Likes
struct MyLikes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Size
struct MySize: Codable {
    let width, height: Int
    let url: URL
    let type: String
}

