//
//  StorageManager.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 19.01.2022.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ photo: UnitedDataModel) {
        
        try! realm.write{
            realm.add(photo)
        }
    }
    
    static func deleteObject(_ photo: UnitedDataModel) {
        
        try! realm.write {
            realm.delete(photo)
        }
    }
    
}

