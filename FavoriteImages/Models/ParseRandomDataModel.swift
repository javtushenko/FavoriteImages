//
//  RandonPhotoData.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 18.01.2022.
//

import UIKit

struct ParseRandomDataModel: Codable {
    let createdAt: String
    let urls: Urls
    let user: User
    let location: Location
    let downloads: Int
}

struct Location: Codable {
    let city, country: String?
}

struct Urls: Codable {
    let regular: String
}

struct User: Codable {
    let username: String
}

