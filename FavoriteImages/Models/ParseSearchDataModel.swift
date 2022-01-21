//
//  SearchModel.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 21.01.2022.
//

import Foundation

struct ParseSearchDataModel: Codable {
    let results: [ResultSearch]?
}

struct ResultSearch: Codable {
    let createdAt: String?
    let urls: UrlsSearch
    let user: UserSearch
}

struct UrlsSearch: Codable {
    let raw, full, regular, small: String
    let thumb: String?
}

struct UserSearch: Codable {
    let username: String?
    let location: String?
}

