//
//  PhotoModel.swift
//  UI_app
//
//  Created by Вячеслав on 28.10.2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photoModel = try? newJSONDecoder().decode(PhotoModel.self, from: jsonData)

import Foundation

// MARK: - PhotoModel
struct PhotoJSON: Codable {
    let response: ResponsePhoto
}

// MARK: - Response
struct ResponsePhoto: Codable {
    let count: Int
    let items: [PhotoStruct]
}

// MARK: - Item
struct PhotoStruct: Codable {
    let albumID: Int
    let id, date: Int
    let text: String
    let sizes: [Size]
    let likes: Likes
    let lat, long: Double?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text, sizes
        case likes, lat, long
    }
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}


// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: URL
    let type: String
}
