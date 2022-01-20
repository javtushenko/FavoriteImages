//
//  RandonPhotoData.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 18.01.2022.
//

import UIKit

struct ParseDataModel: Codable {

    let createdAt: String
    let urls: Urls
    let user: User
    let location: Location
    let downloads: Int

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case urls
        case user, location, downloads
    }
}

// MARK: - Location
struct Location: Codable {
    let city, country: String?
}

// MARK: - Urls
struct Urls: Codable {
    let regular: String
}

// MARK: - User
struct User: Codable {
    let username: String
}

