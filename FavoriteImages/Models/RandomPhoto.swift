//
//  RandomPhoto.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 18.01.2022.
//

import Foundation

struct RandomPhoto {
    
    var createdAt: String
    var urlRegular: String
    var userName: String
    var locationCity: String?
    var locationCountry: String?
    var downloads: Int
    
    init? (randomPhotoData: RandomPhotoData) {
        createdAt = randomPhotoData.createdAt
        urlRegular = randomPhotoData.urls.regular
        userName = randomPhotoData.user.username
        locationCity = randomPhotoData.location.city
        locationCountry = randomPhotoData.location.country
        downloads = randomPhotoData.downloads
    }
}
