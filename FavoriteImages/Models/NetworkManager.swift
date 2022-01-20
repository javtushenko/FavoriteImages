//
//  NetworkManager.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 18.01.2022.
//

import Foundation

protocol NetworkManagerDelegate {
    
    func transportParseArray(_: NetworkManager, with randomPhoto: [FavoriteModel])
}

class NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    var parseArray: [FavoriteModel] = []
    
    // Запрашиваем данные
    func fetchRandomImages() {
        
        let urlString = "https://api.unsplash.com/photos/random/?client_id=\(key)&count=2"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, responce, error in
            if let data = data {
                if let randomPhoto = self.parseJSON(withData: data) {
                    self.createParseArray(with: randomPhoto)
                }
            }
        }
        task.resume()
    }
    
    // Парсим полученые данные
    func parseJSON(withData data: Data) -> [ParseDataModel]? {
        
        let decoder = JSONDecoder()
        do {
            let randomPhotoData = try decoder.decode([ParseDataModel].self, from: data)
            print("Спарсено \(randomPhotoData.count) фото")
            return randomPhotoData
        } catch {
            print(String(describing: error))
        }
        return nil
    }
    
    // Создаем массив с подходящим для Realm классом
    func createParseArray(with randomPhoto: [ParseDataModel]) {
        for index in 0..<randomPhoto.count {
            let newPhoto = FavoriteModel(imageUrl: randomPhoto[index].urls.regular,
                                         nameCreator: randomPhoto[index].user.username,
                                         dateCreator: randomPhoto[index].createdAt,
                                         locationCity: randomPhoto[index].location.city,
                                         locationCountry: randomPhoto[index].location.country,
                                         countDownloads: String(randomPhoto[index].downloads))
            self.parseArray.append(newPhoto)
        }
        self.delegate?.transportParseArray(self, with: parseArray)
        print("Данные загружены в массив")
    }
    
}
