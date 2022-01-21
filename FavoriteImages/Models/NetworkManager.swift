//
//  NetworkManager.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 18.01.2022.
//

import Foundation

protocol NetworkManagerDelegate {
    
    func transportParseArray(_: NetworkManager, with randomPhoto: [UnitedDataModel])
}

class NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    var parseArray: [UnitedDataModel] = []
    
    // Запрашиваем РАНДОМНЫЕ данные
    func fetchRandomImages() {
        
        let urlString = "https://api.unsplash.com/photos/random/?client_id=\(key)&count=8"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, responce, error in
            if let data = data {
                if let randomPhoto = self.parseJSON(withData: data) {
                    self.randomDataToFavoriteModel(with: randomPhoto)
                    print("Спарсено \(randomPhoto.count) фото")
                }
            }
        }
        task.resume()
    }
    
    // Запрашиваем ПОИСКОВЫЕ данные
    func fetchSearchResult(request: String) {
        
        let urlString = "https://api.unsplash.com/search/photos/?client_id=\(key)&page=1&per_page=8&query=\(request)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, responce, error in
            if let data = data {
                if let searchPhoto = self.parseJSONsearch(withData: data) {
                    self.searchDataToFavoriteModel(with: searchPhoto)
                    print("Спарсено \(searchPhoto.results!.count) фото")
                }
            }
        }
        task.resume()
    }
    
    // Парсим полученые РАНДОМНЫЕ данные
    func parseJSON(withData data: Data) -> [ParseRandomDataModel]? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let randomPhotoData = try decoder.decode([ParseRandomDataModel].self, from: data)
            print("Парсинг рандомных данных..")
            return randomPhotoData
        } catch {
            print(String(describing: error))
        }
        return nil
    }
    
    // Парсим полученые ПОИСКОВЫЕ данные
    func parseJSONsearch(withData data: Data) -> ParseSearchDataModel? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let searchPhotoData = try decoder.decode(ParseSearchDataModel.self, from: data)
            print("Парсинг поисковых данных..")
            return searchPhotoData
        } catch {
            print(String(describing: error))
        }
        return nil
    }
    
    // Переводим РАНДОМНЫЕ данные в структуру для Raalm
    func randomDataToFavoriteModel(with randomPhoto: [ParseRandomDataModel]) {
        self.parseArray.removeAll()
        for index in 0..<randomPhoto.count {
            
            let newPhoto = UnitedDataModel(imageUrl: randomPhoto[index].urls.regular,
                                           nameCreator: randomPhoto[index].user.username,
                                           dateCreator: randomPhoto[index].createdAt,
                                           locationCity: randomPhoto[index].location.city,
                                           locationCountry: randomPhoto[index].location.country,
                                           countDownloads: String(randomPhoto[index].downloads))
            self.parseArray.append(newPhoto)
        }
        self.delegate?.transportParseArray(self, with: parseArray)
        print("Данные РАНДОМНЫЕ загружены в массив")
    }
    
    // Переводим РАНДОМНЫЕ данные в структуру для Raalm
    func searchDataToFavoriteModel(with searchData: ParseSearchDataModel) {
        self.parseArray.removeAll()
        guard let searchDatas = searchData.results else { return }
        for index in 0..<searchDatas.count {
            let newPhoto = UnitedDataModel(imageUrl: searchDatas[index].urls.regular,
                                           nameCreator: searchDatas[index].user.username!,
                                           dateCreator: searchDatas[index].createdAt,
                                           locationCity: nil,
                                           locationCountry: searchDatas[index].user.location,
                                           countDownloads: "Данные не получены")
            self.parseArray.append(newPhoto)
        }
        self.delegate?.transportParseArray(self, with: parseArray)
        print("Данные ПОИСКОВЫЕ загружены в массив")
    }
}
