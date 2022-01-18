//
//  NetworkManager.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 18.01.2022.
//

import Foundation

struct NetworkManager {
    
    func fetchRandomImages() {
        
        let urlString = "https://api.unsplash.com/photos/random/?client_id=Y8wZL84qpJw69YAobVJEwvS0rx-f3AqByt_MK8pywbc&count=2"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, responce, error in
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                self.parseJSON(withData: data)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) {
        
        let decoder = JSONDecoder()
        do {
            let randomPhotoData = try decoder.decode([RandonPhotoData].self, from: data)
            print(randomPhotoData.count)
        } catch {
            print(String(describing: error))
        }
    }
    
}
