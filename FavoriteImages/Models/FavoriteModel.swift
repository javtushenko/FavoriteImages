//
//  FavoriteModel.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 19.01.2022.
//

import RealmSwift

class FavoriteModel: Object {
    
    @objc dynamic var imageUrl = ""
    @objc dynamic var nameCreator = "Имя не получено"
    @objc dynamic var dateCreator = "Дата не получена"
    @objc dynamic var locationCity: String?
    @objc dynamic var locationCountry: String?
    @objc dynamic var countDownloads = "Данные не получены"
    
    convenience init( imageUrl: String,
                      nameCreator: String,
                      dateCreator: String,
                      locationCity: String?,
                      locationCountry: String?,
                      countDownloads: String ) {
        self.init()
        self.nameCreator = nameCreator
        self.imageUrl = imageUrl
        self.dateCreator = dateCreator
        self.locationCity = locationCity
        self.locationCountry = locationCountry
        self.countDownloads = countDownloads
    }
}

